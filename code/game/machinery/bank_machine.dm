/obj/machinery/computer/bank_machine
	name = "bank machine"
	desc = "A machine used to deposit and withdraw station funds."
	icon_screen = "vault"
	icon_keyboard = "security_key"
	var/siphoning = FALSE
	var/next_warning = 0
	var/obj/item/radio/radio
	var/radio_channel = RADIO_CHANNEL_COMMON
	var/minimum_time_between_warnings = 400
	var/syphoning_credits = 0

/obj/machinery/computer/bank_machine/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.subspace_transmission = TRUE
	radio.canhear_range = -1
	radio.set_listening(FALSE, TRUE)
	radio.recalculateChannels()

/obj/machinery/computer/bank_machine/Destroy()
	QDEL_NULL(radio)
	. = ..()

/obj/machinery/computer/bank_machine/attackby(obj/item/I, mob/user)
	var/value = 0
	if(istype(I, /obj/item/stack/spacecash))
		var/obj/item/stack/spacecash/C = I
		value = C.get_item_credit_value()
	if(value)
		var/datum/bank_account/D = SSeconomy.department_accounts_by_id[ACCOUNT_CAR]
		if(D)
			D.adjust_money(value)
			to_chat(user, span_notice("You deposit [I]. The Cargo Budget is now [D.account_balance] FM."))
		qdel(I)
		return
	return ..()

/obj/machinery/computer/bank_machine/process(delta_time)
	..()
	if(!siphoning)
		return
	if (machine_stat & (BROKEN|NOPOWER))
		say("Insufficient power. Halting siphon.")
		end_syphon()
		return
	var/siphon_am = 100 * delta_time
	var/datum/bank_account/D = SSeconomy.department_accounts_by_id[ACCOUNT_CAR]
	if(!D.has_money(siphon_am))
		say("Cargo budget depleted. Halting siphon.")
		end_syphon()
		return

	playsound(src, 'sound/items/poster_being_created.ogg', 100, TRUE)
	syphoning_credits += siphon_am
	D.adjust_money(-siphon_am)
	if(next_warning < world.time && prob(15))
		var/area/A = get_area(loc)
		var/message = "Unauthorized credit withdrawal underway in [initial(A.name)]!!"
		radio.talk_into(src, message, radio_channel)
		next_warning = world.time + minimum_time_between_warnings

/obj/machinery/computer/bank_machine/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BankMachine", name)
		ui.open()

/obj/machinery/computer/bank_machine/ui_data(mob/user)
	var/list/data = list()
	var/datum/bank_account/D = SSeconomy.department_accounts_by_id[ACCOUNT_CAR]

	if(D)
		data["current_balance"] = D.account_balance
	else
		data["current_balance"] = 0
	data["siphoning"] = siphoning
	data["station_name"] = station_name()

	return data

/obj/machinery/computer/bank_machine/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("siphon")
			say("Siphon of station credits has begun!")
			siphoning = TRUE
			. = TRUE
		if("halt")
			say("Station credit withdrawal halted.")
			end_syphon()
			. = TRUE

/obj/machinery/computer/bank_machine/proc/end_syphon()
	siphoning = FALSE
	SSeconomy.spawn_cash_for_amount(syphoning_credits, drop_location())
	syphoning_credits = 0
