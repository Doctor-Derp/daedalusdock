TYPEINFO_DEF(/obj/machinery/ai_slipper)
	default_armor = list(BLUNT = 50, PUNCTURE = 20, SLASH = 90, LASER = 20, ENERGY = 20, BOMB = 0, BIO = 0, FIRE = 50, ACID = 30)

/obj/machinery/ai_slipper
	name = "foam dispenser"
	desc = "A remotely-activatable dispenser for crowd-controlling foam."
	icon = 'icons/obj/device.dmi'
	icon_state = "ai-slipper0"
	base_icon_state = "ai-slipper"
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	plane = FLOOR_PLANE
	max_integrity = 200

	var/uses = 20
	var/cooldown = 0
	var/cooldown_time = 100
	req_access = list(ACCESS_AI_UPLOAD)

/obj/machinery/ai_slipper/examine(mob/user)
	. = ..()
	. += span_notice("It has <b>[uses]</b> uses of foam remaining.")

/obj/machinery/ai_slipper/update_icon_state()
	if(machine_stat & BROKEN)
		return ..()
	if((machine_stat & NOPOWER) || cooldown_time > world.time || !uses)
		icon_state = "[base_icon_state]0"
		return ..()
	icon_state = "[base_icon_state]1"
	return ..()

/obj/machinery/ai_slipper/interact(mob/user)
	if(!allowed(user))
		to_chat(user, span_danger("Access denied."))
		return
	if(!uses)
		to_chat(user, span_warning("[src] is out of foam and cannot be activated!"))
		return
	if(cooldown_time > world.time)
		to_chat(user, span_warning("[src] cannot be activated for <b>[DisplayTimeText(world.time - cooldown_time)]</b>!"))
		return
	new /obj/effect/particle_effect/fluid/foam(loc)
	uses--
	to_chat(user, span_notice("You activate [src]. It now has <b>[uses]</b> uses of foam remaining."))
	cooldown = world.time + cooldown_time
	power_change()
	addtimer(CALLBACK(src, PROC_REF(power_change)), cooldown_time)
