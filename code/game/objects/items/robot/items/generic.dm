#define HUG_MODE_NICE 0
#define HUG_MODE_HUG 1
#define HUG_MODE_SHOCK 2
#define HUG_MODE_CRUSH 3

#define HUG_SHOCK_COOLDOWN (2 SECONDS)
#define HUG_CRUSH_COOLDOWN (1 SECONDS)

#define HARM_ALARM_NO_SAFETY_COOLDOWN (60 SECONDS)
#define HARM_ALARM_SAFETY_COOLDOWN (20 SECONDS)

/obj/item/borg
	icon = 'icons/mob/robot_items.dmi'

/obj/item/borg/stun
	name = "electrically-charged arm"
	icon_state = "elecarm"
	/// Cost to use the stun arm
	var/charge_cost = 1000

/obj/item/borg/stun/attack(mob/living/attacked_mob, mob/living/user)
	if(ishuman(attacked_mob))
		var/mob/living/carbon/human/human = attacked_mob
		if(human.check_block(src, 0, "[attacked_mob]'s [name]", MELEE_ATTACK))
			playsound(attacked_mob, 'sound/weapons/genhit.ogg', 50, TRUE)
			return FALSE
	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user
		if(!robot_user.cell.use(charge_cost))
			return

	user.do_attack_animation(attacked_mob)
	attacked_mob.Paralyze(100)
	attacked_mob.adjust_timed_status_effect(10 SECONDS, /datum/status_effect/speech/stutter)

	attacked_mob.visible_message(span_danger("[user] prods [attacked_mob] with [src]!"), \
					span_userdanger("[user] prods you with [src]!"))

	playsound(loc, 'sound/weapons/egloves.ogg', 50, TRUE, -1)

	log_combat(user, attacked_mob, "stunned", src, "(Combat mode: [user.combat_mode ? "On" : "Off"])")

/obj/item/borg/cyborghug
	name = "hugging module"
	icon_state = "hugmodule"
	desc = "For when a someone really needs a hug."
	/// Hug mode
	var/mode = HUG_MODE_NICE
	/// Crush cooldown
	COOLDOWN_DECLARE(crush_cooldown)
	/// Shock cooldown
	COOLDOWN_DECLARE(shock_cooldown)
	/// Can it be a stunarm when emagged. Only PK borgs get this by default.
	var/shockallowed = FALSE
	var/boop = FALSE

/obj/item/borg/cyborghug/attack_self(mob/living/user)
	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user
		if(robot_user.emagged && shockallowed == 1)
			if(mode < HUG_MODE_CRUSH)
				mode++
			else
				mode = HUG_MODE_NICE
		else if(mode < HUG_MODE_HUG)
			mode++
		else
			mode = HUG_MODE_NICE
	switch(mode)
		if(HUG_MODE_NICE)
			to_chat(user, "<span class='infoplain'>Power reset. Hugs!</span>")
		if(HUG_MODE_HUG)
			to_chat(user, "<span class='infoplain'>Power increased!</span>")
		if(HUG_MODE_SHOCK)
			to_chat(user, "<span class='warningplain'>BZZT. Electrifying arms...</span>")
		if(HUG_MODE_CRUSH)
			to_chat(user, "<span class='warningplain'>ERROR: ARM ACTUATORS OVERLOADED.</span>")

/obj/item/borg/cyborghug/attack(mob/living/attacked_mob, mob/living/silicon/robot/user, params)
	if(attacked_mob == user)
		return
	if(attacked_mob.health < 0)
		return
	switch(mode)
		if(HUG_MODE_NICE)
			if(isanimal(attacked_mob))
				var/list/modifiers = params2list(params)
				if (!user.combat_mode && !LAZYACCESS(modifiers, RIGHT_CLICK))
					attacked_mob.attack_hand(user, modifiers) //This enables borgs to get the floating heart icon and mob emote from simple_animal's that have petbonus == true.
				return
			if(user.zone_selected == BODY_ZONE_HEAD)
				user.visible_message(span_notice("[user] playfully boops [attacked_mob] on the head!"), \
								span_notice("You playfully boop [attacked_mob] on the head!"))
				user.do_attack_animation(attacked_mob, ATTACK_EFFECT_BOOP)
				playsound(loc, 'sound/weapons/tap.ogg', 50, TRUE, -1)
			else if(ishuman(attacked_mob))
				if(user.body_position == LYING_DOWN)
					user.visible_message(span_notice("[user] shakes [attacked_mob] trying to get [attacked_mob.p_them()] up!"), \
									span_notice("You shake [attacked_mob] trying to get [attacked_mob.p_them()] up!"))
				else
					user.visible_message(span_notice("[user] hugs [attacked_mob] to make [attacked_mob.p_them()] feel better!"), \
							span_notice("You hug [attacked_mob] to make [attacked_mob.p_them()] feel better!"))
				if(attacked_mob.resting)
					attacked_mob.set_resting(FALSE, TRUE)
			else
				user.visible_message(span_notice("[user] pets [attacked_mob]!"), \
						span_notice("You pet [attacked_mob]!"))
			playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
		if(HUG_MODE_HUG)
			if(ishuman(attacked_mob))
				attacked_mob.adjust_status_effects_on_shake_up()
				if(attacked_mob.body_position == LYING_DOWN)
					user.visible_message(span_notice("[user] shakes [attacked_mob] trying to get [attacked_mob.p_them()] up!"), \
									span_notice("You shake [attacked_mob] trying to get [attacked_mob.p_them()] up!"))
				else if(user.zone_selected == BODY_ZONE_HEAD)
					user.visible_message(span_warning("[user] bops [attacked_mob] on the head!"), \
									span_warning("You bop [attacked_mob] on the head!"))
					user.do_attack_animation(attacked_mob, ATTACK_EFFECT_PUNCH)
				else
					user.visible_message(span_warning("[user] hugs [attacked_mob] in a firm bear-hug! [attacked_mob] looks uncomfortable..."), \
							span_warning("You hug [attacked_mob] firmly to make [attacked_mob.p_them()] feel better! [attacked_mob] looks uncomfortable..."))
				if(attacked_mob.resting)
					attacked_mob.set_resting(FALSE, TRUE)
			else
				user.visible_message(span_warning("[user] bops [attacked_mob] on the head!"), \
						span_warning("You bop [attacked_mob] on the head!"))
			playsound(loc, 'sound/weapons/tap.ogg', 50, TRUE, -1)
		if(HUG_MODE_SHOCK)
			if (!COOLDOWN_FINISHED(src, shock_cooldown))
				return
			if(ishuman(attacked_mob))
				attacked_mob.electrocute_act(5, "[user]", flags = NONE)
				user.visible_message(span_userdanger("[user] electrocutes [attacked_mob] with [user.p_their()] touch!"), \
					span_danger("You electrocute [attacked_mob] with your touch!"))
			else
				if(!iscyborg(attacked_mob))
					attacked_mob.adjustFireLoss(10)
					user.visible_message(span_userdanger("[user] shocks [attacked_mob]!"), \
						span_danger("You shock [attacked_mob]!"))
				else
					user.visible_message(span_userdanger("[user] shocks [attacked_mob]. It does not seem to have an effect"), \
						span_danger("You shock [attacked_mob] to no effect."))
			playsound(loc, 'sound/effects/sparks2.ogg', 50, TRUE, -1)
			user.cell.charge -= 500
			COOLDOWN_START(src, shock_cooldown, HUG_SHOCK_COOLDOWN)
		if(HUG_MODE_CRUSH)
			if (!COOLDOWN_FINISHED(src, crush_cooldown))
				return
			if(ishuman(attacked_mob))
				user.visible_message(span_userdanger("[user] crushes [attacked_mob] in [user.p_their()] grip!"), \
					span_danger("You crush [attacked_mob] in your grip!"))
			else
				user.visible_message(span_userdanger("[user] crushes [attacked_mob]!"), \
						span_danger("You crush [attacked_mob]!"))
			playsound(loc, 'sound/weapons/smash.ogg', 50, TRUE, -1)
			attacked_mob.adjustBruteLoss(15)
			user.cell.charge -= 300
			COOLDOWN_START(src, crush_cooldown, HUG_CRUSH_COOLDOWN)

/obj/item/borg/cyborghug/peacekeeper
	shockallowed = TRUE

/obj/item/borg/cyborghug/medical
	boop = TRUE

/obj/item/borg/charger
	name = "power connector"
	icon_state = "charger_draw"
	item_flags = NOBLUDGEON
	/// Charging mode
	var/mode = "draw"
	/// Whitelist of charging machines
	var/static/list/charge_machines = typecacheof(list(/obj/machinery/cell_charger, /obj/machinery/recharger, /obj/machinery/recharge_station, /obj/machinery/mech_bay_recharge_port))
	/// Whitelist of chargable items
	var/static/list/charge_items = typecacheof(list(/obj/item/stock_parts/cell, /obj/item/gun/energy))

/obj/item/borg/charger/update_icon_state()
	icon_state = "charger_[mode]"
	return ..()

/obj/item/borg/charger/attack_self(mob/user)
	if(mode == "draw")
		mode = "charge"
	else
		mode = "draw"
	to_chat(user, span_notice("You toggle [src] to \"[mode]\" mode."))
	update_appearance()

/obj/item/borg/charger/interact_with_atom(atom/interacting_with, mob/living/silicon/robot/user, list/modifiers)
	if(!iscyborg(user))
		return NONE

	var/atom/target = interacting_with // Yes i am supremely lazy

	if(mode == "draw")
		if(is_type_in_list(target, charge_machines))
			var/obj/machinery/target_machine = target
			if((target_machine.machine_stat & (NOPOWER|BROKEN)) || !target_machine.anchored)
				to_chat(user, span_warning("[target_machine] is unpowered!"))
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_notice("You connect to [target_machine]'s power line..."))
			while(do_after(user, target_machine, 1.5 SECONDS, progress = 0))
				if(!user || !user.cell || mode != "draw")
					return

				if((target_machine.machine_stat & (NOPOWER|BROKEN)) || !target_machine.anchored)
					break

				if(!user.cell.give(150))
					break

				target_machine.use_power(200)

			to_chat(user, span_notice("You stop charging yourself."))

		else if(is_type_in_list(target, charge_items))
			var/obj/item/stock_parts/cell/cell = target
			if(!istype(cell))
				cell = locate(/obj/item/stock_parts/cell) in target
			if(!cell)
				to_chat(user, span_warning("[target] has no power cell!"))
				return

			if(istype(target, /obj/item/gun/energy))
				var/obj/item/gun/energy/energy_gun = target
				if(!energy_gun.can_charge)
					to_chat(user, span_warning("[target] has no power port!"))
					return ITEM_INTERACT_BLOCKING

			if(!cell.charge)
				to_chat(user, span_warning("[target] has no power!"))


			to_chat(user, span_notice("You connect to [target]'s power port..."))

			while(do_after(user, target, 1.5 SECONDS, progress = 0))
				if(!user || !user.cell || mode != "draw")
					return ITEM_INTERACT_BLOCKING

				if(!cell || !target)
					return ITEM_INTERACT_BLOCKING

				if(cell != target && cell.loc != target)
					return  ITEM_INTERACT_BLOCKING

				var/draw = min(cell.charge, cell.chargerate*0.5, user.cell.maxcharge - user.cell.charge)
				if(!cell.use(draw))
					break
				if(!user.cell.give(draw))
					break
				target.update_appearance()

			to_chat(user, span_notice("You stop charging yourself."))

	else if(is_type_in_list(target, charge_items))
		var/obj/item/stock_parts/cell/cell = target
		if(!istype(cell))
			cell = locate(/obj/item/stock_parts/cell) in target
		if(!cell)
			to_chat(user, span_warning("[target] has no power cell!"))
			return ITEM_INTERACT_BLOCKING

		if(istype(target, /obj/item/gun/energy))
			var/obj/item/gun/energy/energy_gun = target
			if(!energy_gun.can_charge)
				to_chat(user, span_warning("[target] has no power port!"))
				return ITEM_INTERACT_BLOCKING

		if(cell.charge >= cell.maxcharge)
			to_chat(user, span_warning("[target] is already charged!"))

		to_chat(user, span_notice("You connect to [target]'s power port..."))

		while(do_after(user, target, 1.5 SECONDS, progress = 0))
			if(!user || !user.cell || mode != "charge")
				return

			if(!cell || !target)
				return

			if(cell != target && cell.loc != target)
				return

			var/draw = min(user.cell.charge, cell.chargerate * 0.5, cell.maxcharge - cell.charge)
			if(!user.cell.use(draw))
				break
			if(!cell.give(draw))
				break
			target.update_appearance()

		to_chat(user, span_notice("You stop charging [target]."))

	return ITEM_INTERACT_SUCCESS

/obj/item/harmalarm
	name = "\improper Sonic Harm Prevention Tool"
	desc = "Releases a harmless blast that confuses most organics. For when the harm is JUST TOO MUCH."
	icon = 'icons/obj/device.dmi'
	icon_state = "megaphone"
	/// Harm alarm cooldown
	COOLDOWN_DECLARE(alarm_cooldown)

/obj/item/harmalarm/emag_act(mob/user)
	obj_flags ^= EMAGGED
	if(obj_flags & EMAGGED)
		to_chat(user, "<font color='red'>You short out the safeties on [src]!</font>")
	else
		to_chat(user, "<font color='red'>You reset the safeties on [src]!</font>")

/obj/item/harmalarm/attack_self(mob/user)
	var/safety = !(obj_flags & EMAGGED)
	if (!COOLDOWN_FINISHED(src, alarm_cooldown))
		to_chat(user, "<font color='red'>The device is still recharging!</font>")
		return

	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user
		if(!robot_user.cell || robot_user.cell.charge < 1200)
			to_chat(user, span_warning("You don't have enough charge to do this!"))
			return
		robot_user.cell.charge -= 1000
		if(robot_user.emagged)
			safety = FALSE

	if(safety == TRUE)
		user.visible_message("<font color='red' size='2'>[user] blares out a near-deafening siren from its speakers!</font>", \
			span_userdanger("The siren pierces your hearing and confuses you!"), \
			span_danger("The siren pierces your hearing!"))
		for(var/mob/living/carbon/carbon in get_hearers_in_view(9, user))
			if(carbon.get_ear_protection())
				continue
			carbon.adjust_timed_status_effect(6 SECONDS, /datum/status_effect/confusion)

		audible_message("<font color='red' size='7'>HUMAN HARM</font>")
		playsound(get_turf(src), 'sound/ai/harmalarm.ogg', 70, 3)
		COOLDOWN_START(src, alarm_cooldown, HARM_ALARM_SAFETY_COOLDOWN)
		user.log_message("used a Cyborg Harm Alarm in [AREACOORD(user)]", LOG_ATTACK)
		if(iscyborg(user))
			var/mob/living/silicon/robot/robot_user = user
			to_chat(robot_user.connected_ai, "<br>[span_notice("NOTICE - Peacekeeping 'HARM ALARM' used by: [user]")]<br>")
	else
		user.audible_message("<font color='red' size='7'>BZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZT</font>")
		for(var/mob/living/carbon/carbon in get_hearers_in_view(9, user))
			var/bang_effect = carbon.soundbang_act(2, 0, 0, 5)
			switch(bang_effect)
				if(1)
					carbon.adjust_timed_status_effect(5 SECONDS, /datum/status_effect/confusion)
					carbon.adjust_timed_status_effect(20 SECONDS, /datum/status_effect/speech/stutter)
					carbon.adjust_timed_status_effect(20 SECONDS, /datum/status_effect/jitter)
				if(2)
					carbon.Paralyze(40)
					carbon.adjust_timed_status_effect(10 SECONDS, /datum/status_effect/confusion)
					carbon.adjust_timed_status_effect(30 SECONDS, /datum/status_effect/speech/stutter)
					carbon.adjust_timed_status_effect(50 SECONDS, /datum/status_effect/jitter)
		playsound(get_turf(src), 'sound/machines/warning-buzzer.ogg', 130, 3)
		COOLDOWN_START(src, alarm_cooldown, HARM_ALARM_NO_SAFETY_COOLDOWN)
		user.log_message("used an emagged Cyborg Harm Alarm in [AREACOORD(user)]", LOG_ATTACK)
