/obj/item/firing_pin
	name = "electronic firing pin"
	desc = "A small authentication device, to be inserted into a firearm receiver to allow operation. NT safety regulations require all new designs to incorporate one."
	icon = 'icons/obj/device.dmi'
	icon_state = "firing_pin"
	inhand_icon_state = "pen"
	worn_icon_state = "pen"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("pokes")
	attack_verb_simple = list("poke")

	var/fail_message = "invalid user!"
	var/selfdestruct = FALSE // Explode when user check is failed.
	var/force_replace = FALSE // Can forcefully replace other pins.
	var/pin_removeable = FALSE // Can be replaced by any pin.

	/// The gun we're apart of.
	var/obj/item/gun/gun

/obj/item/firing_pin/Initialize(mapload, obj/item/gun/owner)
	. = ..()
	if(isgun(owner))
		gun = owner

/obj/item/firing_pin/Destroy()
	if(gun)
		gun.pin = null
	return ..()

/obj/item/firing_pin/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/atom/target = interacting_with // Yes i am supremely lazy

	if(!isgun(target))
		return NONE

	var/obj/item/gun/targetted_gun = target
	var/obj/item/firing_pin/old_pin = targetted_gun.pin
	if(old_pin && (force_replace || old_pin.pin_removeable))
		to_chat(user, span_notice("You remove [old_pin] from [targetted_gun]."))
		if(Adjacent(user))
			user.put_in_hands(old_pin)
		else
			old_pin.forceMove(targetted_gun.drop_location())
		old_pin.gun_remove(user)

	if(!targetted_gun.pin)
		if(!user.temporarilyRemoveItemFromInventory(src))
			return ITEM_INTERACT_BLOCKING

		if(gun_insert(user, targetted_gun))
			to_chat(user, span_notice("You insert [src] into [targetted_gun]."))
	else
		to_chat(user, span_notice("This firearm already has a firing pin installed."))

	return ITEM_INTERACT_SUCCESS

/obj/item/firing_pin/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(user, span_notice("You override the authentication mechanism."))

/obj/item/firing_pin/proc/gun_insert(mob/living/user, obj/item/gun/G)
	gun = G
	forceMove(gun)
	gun.pin = src
	return TRUE

/obj/item/firing_pin/proc/gun_remove(mob/living/user)
	gun.pin = null
	gun = null
	return

/obj/item/firing_pin/proc/pin_auth(mob/living/user)
	return TRUE

/obj/item/firing_pin/proc/auth_fail(mob/living/user)
	if(user)
		user.show_message(fail_message, MSG_VISUAL)
	if(selfdestruct)
		if(user)
			user.show_message("[span_danger("SELF-DESTRUCTING...")]<br>", MSG_VISUAL)
			to_chat(user, span_userdanger("[gun] explodes!"))
		explosion(src, devastation_range = -1, light_impact_range = 2, flash_range = 3)
		if(gun)
			qdel(gun)


/obj/item/firing_pin/magic
	name = "magic crystal shard"
	desc = "A small enchanted shard which allows magical weapons to fire."

// DNA-keyed pin.
// When you want to keep your toys for yourself.
/obj/item/firing_pin/dna
	name = "DNA-keyed firing pin"
	desc = "This is a DNA-locked firing pin which only authorizes one user. Attempt to fire once to DNA-link."
	icon_state = "firing_pin_dna"
	fail_message = "dna check failed!"
	var/unique_enzymes = null

/obj/item/firing_pin/dna/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return

	if(iscarbon(interacting_with))
		var/mob/living/carbon/M = interacting_with
		if(M.dna && M.dna.unique_enzymes)
			unique_enzymes = M.dna.unique_enzymes
			to_chat(user, span_notice("DNA-LOCK SET."))
			return ITEM_INTERACT_SUCCESS

/obj/item/firing_pin/dna/pin_auth(mob/living/carbon/user)
	if(user && user.dna && user.dna.unique_enzymes)
		if(user.dna.unique_enzymes == unique_enzymes)
			return TRUE
	return FALSE

/obj/item/firing_pin/dna/auth_fail(mob/living/carbon/user)
	if(!unique_enzymes)
		if(user && user.dna && user.dna.unique_enzymes)
			unique_enzymes = user.dna.unique_enzymes
			to_chat(user, span_notice("DNA-LOCK SET."))
	else
		..()

// Paywall pin, brought to you by ARMA 3 DLC.
// Checks if the user has a valid bank account on an ID and if so attempts to extract a one-time payment to authorize use of the gun. Otherwise fails to shoot.
/obj/item/firing_pin/paywall
	name = "paywall firing pin"
	desc = "A firing pin with a built-in configurable paywall."
	color = "#FFD700"
	fail_message = ""
	///list of account IDs which have accepted the license prompt. If this is the multi-payment pin, then this means they accepted the waiver that each shot will cost them money
	var/list/gun_owners = list()
	///how much gets paid out to license yourself to the gun
	var/payment_amount
	var/datum/bank_account/pin_owner
	///if true, user has to pay everytime they fire the gun
	var/multi_payment = FALSE
	var/owned = FALSE
	///purchase prompt to prevent spamming it, set to the user who opens to prompt to prevent locking the gun up for other users.
	var/active_prompt_user

/obj/item/firing_pin/paywall/attack_self(mob/user)
	multi_payment = !multi_payment
	to_chat(user, span_notice("You set the pin to [( multi_payment ) ? "process payment for every shot" : "one-time license payment"]."))

/obj/item/firing_pin/paywall/examine(mob/user)
	. = ..()
	if(pin_owner)
		. += span_notice("This firing pin is currently authorized to pay into the account of [pin_owner.account_holder].")

/obj/item/firing_pin/paywall/gun_insert(mob/living/user, obj/item/gun/G)
	if(!pin_owner)
		to_chat(user, span_warning("ERROR: Please swipe valid identification card before installing firing pin!"))
		user.put_in_hands(src)
		return FALSE
	gun = G
	forceMove(gun)
	gun.pin = src
	if(multi_payment)
		gun.desc += span_notice(" This [gun.name] has a per-shot cost of [payment_amount] credit[( payment_amount > 1 ) ? "s" : ""].")
		return TRUE
	gun.desc += span_notice(" This [gun.name] has a license permit cost of [payment_amount] credit[( payment_amount > 1 ) ? "s" : ""].")
	return TRUE


/obj/item/firing_pin/paywall/gun_remove(mob/living/user)
	gun.desc = initial(desc)
	..()

/obj/item/firing_pin/paywall/attackby(obj/item/M, mob/living/user, params)
	if(isidcard(M))
		var/obj/item/card/id/id = M
		if(!id.registered_account)
			to_chat(user, span_warning("ERROR: Identification card lacks registered bank account!"))
			return
		if(id.registered_account != pin_owner && owned)
			to_chat(user, span_warning("ERROR: This firing pin has already been authorized!"))
			return
		if(id.registered_account == pin_owner)
			to_chat(user, span_notice("You unlink the card from the firing pin."))
			gun_owners -= user.get_bank_account()
			pin_owner = null
			owned = FALSE
			return
		var/transaction_amount = tgui_input_number(user, "Insert valid deposit amount for gun purchase", "Money Deposit")
		if(!transaction_amount || QDELETED(user) || QDELETED(src) || !user.canUseTopic(src, USE_CLOSE|USE_IGNORE_TK))
			return
		pin_owner = id.registered_account
		owned = TRUE
		payment_amount = transaction_amount
		gun_owners += user.get_bank_account()
		to_chat(user, span_notice("You link the card to the firing pin."))

/obj/item/firing_pin/paywall/pin_auth(mob/living/user)
	if(!istype(user))//nice try commie
		return FALSE
	var/datum/bank_account/credit_card_details = user.get_bank_account()
	if(credit_card_details in gun_owners)
		if(multi_payment && credit_card_details)
			if(!gun.can_fire())
				return TRUE //So you don't get charged for attempting to fire an empty gun.
			if(credit_card_details.adjust_money(-payment_amount, "Firing Pin: Gun Rent"))
				if(pin_owner)
					pin_owner.adjust_money(payment_amount, "Firing Pin: Payout For Gun Rent")
				return TRUE
			to_chat(user, span_warning("ERROR: User balance insufficent for successful transaction!"))
			return FALSE
		return TRUE
	if(!credit_card_details)
		to_chat(user, span_warning("ERROR: User has no valid bank account to subtract neccesary funds from!"))
		return FALSE
	if(active_prompt_user == user)
		return FALSE
	active_prompt_user = user
	var/license_request = tgui_alert(user, "Do you wish to pay [payment_amount] credit[( payment_amount > 1 ) ? "s" : ""] for [( multi_payment ) ? "each shot of [gun.name]" : "usage license of [gun.name]"]?", "Weapon Purchase", list("Yes", "No"), 15 SECONDS)
	if(!user.canUseTopic(src))
		active_prompt_user = null
		return FALSE
	switch(license_request)
		if("Yes")
			if(multi_payment)
				gun_owners += credit_card_details
				to_chat(user, span_notice("Gun rental terms agreed to, have a secure day!"))

			else if(credit_card_details.adjust_money(-payment_amount, "Firing Pin: Gun License"))
				if(pin_owner)
					pin_owner.adjust_money(payment_amount, "Firing Pin: Gun License Bought")
				gun_owners += credit_card_details
				to_chat(user, span_notice("Gun license purchased, have a secure day!"))

			else
				to_chat(user, span_warning("ERROR: User balance insufficent for successful transaction!"))

		if("No", null)
			to_chat(user, span_warning("ERROR: User has declined to purchase gun license!"))
	active_prompt_user = null
	return FALSE //we return false here so you don't click initially to fire, get the prompt, accept the prompt, and THEN the gun

// Laser tag pins
/obj/item/firing_pin/tag
	name = "laser tag firing pin"
	desc = "A recreational firing pin, used in laser tag units to ensure users have their vests on."
	fail_message = "suit check failed!"
	var/obj/item/clothing/suit/suit_requirement = null
	var/tagcolor = ""

/obj/item/firing_pin/tag/pin_auth(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/M = user
		if(istype(M.wear_suit, suit_requirement))
			return TRUE
	to_chat(user, span_warning("You need to be wearing [tagcolor] laser tag armor!"))
	return FALSE

/obj/item/firing_pin/tag/red
	name = "red laser tag firing pin"
	icon_state = "firing_pin_red"
	suit_requirement = /obj/item/clothing/suit/redtag
	tagcolor = "red"

/obj/item/firing_pin/tag/blue
	name = "blue laser tag firing pin"
	icon_state = "firing_pin_blue"
	suit_requirement = /obj/item/clothing/suit/bluetag
	tagcolor = "blue"
