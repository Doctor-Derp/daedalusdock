/* Tables and Racks
 * Contains:
 * Tables
 * Glass Tables
 * Wooden Tables
 * Reinforced Tables
 * Racks
 * Rack Parts
 */

/*
 * Tables
 */

TYPEINFO_DEF(/obj/structure/table)
	default_materials = list(/datum/material/iron = 2000)

/obj/structure/table
	name = "table"
	desc = "A square piece of iron standing on four metal legs. It can not move."
	icon = 'icons/obj/smooth_structures/table.dmi'
	icon_state = "table-0"
	base_icon_state = "table"
	density = TRUE
	anchored = TRUE
	pass_flags_self = PASSTABLE | LETPASSTHROW
	layer = TABLE_LAYER
	max_integrity = 100
	integrity_failure = 0.33
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TABLES
	canSmoothWith = SMOOTH_GROUP_TABLES
	flags_1 = BUMP_PRIORITY_1
	mouse_drop_pointer = TRUE

	/// A url-encoded list defining the bounds that objects can be placed on. Just a visual enhancement
	var/placable_bounds = "x1=6&y1=11&x2=27&y2=27"

	var/frame = /obj/structure/table_frame
	var/framestack = /obj/item/stack/rods
	var/buildstack = /obj/item/stack/sheet/iron
	var/busy = FALSE
	var/buildstackamount = 1
	var/framestackamount = 2
	var/deconstruction_ready = 1
	/// Are we flipped over? -1 is unflippable
	var/flipped = FALSE

/obj/structure/table/Initialize(mapload, _buildstack)
	. = ..()
	if(_buildstack)
		buildstack = _buildstack

	AddElement(/datum/element/footstep_override, priority = STEP_SOUND_TABLE_PRIORITY)
	AddElement(/datum/element/climbable)

	var/static/list/loc_connections = list(
		COMSIG_CARBON_DISARM_COLLIDE = PROC_REF(table_carbon),
		COMSIG_ATOM_ENTERED = PROC_REF(on_crossed),
		COMSIG_ATOM_EXIT = PROC_REF(check_exit),
		COMSIG_ATOM_EXITED = PROC_REF(on_uncrossed),
	)

	AddElement(/datum/element/connect_loc, loc_connections)

	if (!(flags_1 & NODECONSTRUCT_1))
		var/static/list/tool_behaviors = list(
			TOOL_SCREWDRIVER = list(
				SCREENTIP_CONTEXT_RMB = "Disassemble",
			),

			TOOL_WRENCH = list(
				SCREENTIP_CONTEXT_RMB = "Deconstruct",
			),
		)

		AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)
		register_context()

/obj/structure/table/examine(mob/user)
	. = ..()
	. += deconstruction_hints(user)

/obj/structure/table/proc/deconstruction_hints(mob/user)
	return span_notice("The top is <b>screwed</b> on, but the main <b>bolts</b> are also visible.")

/obj/structure/table/update_icon(updates=ALL)
	. = ..()

	if(is_flipped())
		icon = 'icons/obj/flipped_tables.dmi'
		icon_state = base_icon_state
	else
		icon = initial(icon)

	if((updates & UPDATE_SMOOTHING))
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)


/obj/structure/table/narsie_act()
	var/atom/A = loc
	qdel(src)
	new /obj/structure/table/wood(A)

/obj/structure/table/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/table/attack_tk(mob/user)
	return

/obj/structure/table/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	var/mob/living/L = usr
	if(!istype(L))
		return
	if(!L.combat_mode)
		return
	if(!can_interact(L))
		return
	if(!over.Adjacent(src))
		return

	if(is_flipped())
		if(get_turf(over) == loc)
			unflip(L)
			return
	else
		flip(L, get_cardinal_dir(src, over))
		return

/obj/structure/table/MouseDroppedOn(atom/dropping, mob/living/user, list/params)
	. = ..()
	if(ishuman(dropping))
		if(dropping != user)
			try_place_pulled_onto_table(user, dropping)
			return
		var/mob/living/carbon/human/H = user
		if(H.incapacitated() || H.body_position == LYING_DOWN || !H.combat_mode)
			return
		if(!H.Adjacent(src))
			return FALSE
		if(!H.Enter(get_turf(src), TRUE))
			return

		H.apply_damage(5, BRUTE, BODY_ZONE_HEAD)
		H.apply_pain(80, BODY_ZONE_HEAD, "Your head screams with pain!")
		H.Paralyze(1 SECOND)
		playsound(H, 'sound/items/trayhit1.ogg', 50, 1)
		H.visible_message(
			span_danger("[H] bangs [H.p_their()] head on [src]."),
			span_danger("You bang your head on [src]."),
			span_hear("You hear a metallic clang.")

		)
		return

	if(isitem(dropping))
		if(!LAZYACCESS(params, ICON_X) || !LAZYACCESS(params, ICON_Y))
			return

		var/obj/item/I = dropping
		if(!user.can_equip(I, ITEM_SLOT_HANDS, TRUE, TRUE))
			return

		if(!(I.loc == loc))
			return

		var/list/center = I.get_icon_center()
		var/half_icon_width = world.icon_size / 2

		var/x_offset = center["x"] - half_icon_width
		var/y_offset = center["y"] - half_icon_width

		var/x_diff = (text2num(params[ICON_X]) - half_icon_width)
		var/y_diff = (text2num(params[ICON_Y]) - half_icon_width)

		var/list/bounds = get_placable_bounds()
		var/new_x = clamp(pixel_x + x_diff, bounds["x1"] - half_icon_width, bounds["x2"] - half_icon_width)
		var/new_y = clamp(pixel_y + y_diff, bounds["y1"] - half_icon_width, bounds["y2"] - half_icon_width)

		for(var/atom/movable/AM as anything in I.get_associated_mimics() + I)
			animate(AM, pixel_x = new_x + x_offset, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
			animate(pixel_y = new_y + y_offset, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
		return

/obj/structure/table/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return
	if(isprojectile(mover))
		return check_cover(mover, get_turf(mover))

	if(mover.throwing)
		return TRUE

	var/obj/structure/table/T = locate() in get_turf(mover)
	if(T && !T.is_flipped())
		return TRUE

	var/obj/structure/low_wall/L = locate() in get_turf(mover)
	if(L)
		return TRUE

	if(is_flipped() && !(border_dir & dir))
		return TRUE

/obj/structure/table/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	if(!density)
		return TRUE

	if((pass_info.pass_flags & PASSTABLE) || (is_flipped() && (dir != to_dir)))
		return TRUE

	return FALSE

/obj/structure/table/proc/check_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER
	if(!density)
		return

	if(isprojectile(leaving) && !check_cover(leaving, get_turf(leaving)))
		leaving.Bump(src)
		return COMPONENT_ATOM_BLOCK_EXIT

	if(is_flipped() && (direction & dir))
		return COMPONENT_ATOM_BLOCK_EXIT

//checks if projectile 'P' from turf 'from' can hit whatever is behind the table. Returns 1 if it can, 0 if bullet stops.
/obj/structure/table/proc/check_cover(obj/projectile/P, turf/from)
	var/turf/cover
	if(is_flipped())
		cover = get_turf(src)
	else
		cover = get_step(loc, get_dir(from, loc))
	if(!cover)
		return TRUE
	if (get_dist(P.starting, loc) <= 1) //Tables won't help you if people are THIS close
		return TRUE

	var/chance = 0
	if(ismob(P.original) && get_turf(P.original) == cover)
		var/mob/living/L = P.original
		if (L.body_position == LYING_DOWN)
			chance += 40 //Lying down lets you catch less bullets

	if(is_flipped())
		if(get_dir(loc, from) == dir || get_dir(loc, from) == turn(dir, 180)) //Flipped tables catch more bullets
			chance += 30

	if(prob(chance))
		return FALSE //blocked
	return TRUE

/obj/structure/table/proc/on_crossed(atom/movable/crossed_by, oldloc, list/old_locs)
	SIGNAL_HANDLER
	if(!isliving(crossed_by))
		return

	if(!istype(src, /obj/structure/table/optable))
		if(!HAS_TRAIT(crossed_by, TRAIT_TABLE_RISEN))
			ADD_TRAIT(crossed_by, TRAIT_TABLE_RISEN, TRAIT_GENERIC)

/obj/structure/table/proc/on_uncrossed(datum/source, atom/movable/gone, direction)
	SIGNAL_HANDLER
	if(!isliving(gone))
		return

	if(!istype(src, /obj/structure/table/optable))
		if(HAS_TRAIT(gone, TRAIT_TABLE_RISEN))
			REMOVE_TRAIT(gone, TRAIT_TABLE_RISEN, TRAIT_GENERIC)

/obj/structure/table/setDir(ndir)
	. = ..()
	if(dir != NORTH && dir != 0 && (is_flipped()))
		layer = ABOVE_MOB_LAYER
	else
		layer = TABLE_LAYER

/obj/structure/table/attack_grab(mob/living/user, atom/movable/victim, obj/item/hand_item/grab/grab, list/params)
	try_place_pulled_onto_table(user, victim, grab)
	return TRUE

/obj/structure/table/proc/try_place_pulled_onto_table(mob/living/user, atom/movable/target, obj/item/hand_item/grab/grab)
	if(!Adjacent(user))
		return

	if(isliving(target))
		var/mob/living/pushed_mob = target
		if(pushed_mob.buckled)
			to_chat(user, span_warning("[pushed_mob] is buckled to [pushed_mob.buckled]!"))
			return

		if(user.combat_mode && grab)
			switch(grab.current_grab.damage_stage)
				if(GRAB_PASSIVE)
					to_chat(user, span_warning("You need a better grip to do that!"))
					return

				if(GRAB_NECK, GRAB_KILL)
					tablepush(user, pushed_mob)
				else
					if(grab.target_zone == BODY_ZONE_HEAD)
						tablelimbsmash(user, pushed_mob)
		else
			pushed_mob.visible_message(span_notice("[user] begins to place [pushed_mob] onto [src]..."), \
								span_userdanger("[user] begins to place [pushed_mob] onto [src]..."))
			if(do_after(user, pushed_mob, 3.5 SECONDS, DO_PUBLIC))
				tableplace(user, pushed_mob)
			else
				return
		user.release_grabs(pushed_mob)

	else if(target.pass_flags & PASSTABLE)
		grab.move_victim_towards(src)
		if (target.loc == loc)
			user.visible_message(span_notice("[user] places [target] onto [src]."),
				span_notice("You place [target] onto [src]."))

			user.release_grabs(target)

/obj/structure/table/proc/tableplace(mob/living/user, mob/living/pushed_mob)
	pushed_mob.forceMove(loc)
	pushed_mob.set_resting(TRUE, TRUE)
	pushed_mob.visible_message(span_notice("[user] places [pushed_mob] onto [src]."), \
								span_notice("[user] places [pushed_mob] onto [src]."))
	log_combat(user, pushed_mob, "places", null, "onto [src]")

/obj/structure/table/proc/tablepush(mob/living/user, mob/living/pushed_mob)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_danger("Throwing [pushed_mob] onto the table might hurt them!"))
		return
	var/added_passtable = FALSE
	if(!(pushed_mob.pass_flags & PASSTABLE))
		added_passtable = TRUE
		pushed_mob.pass_flags |= PASSTABLE
	for (var/obj/obj in user.loc.contents)
		if(!obj.CanAllowThrough(pushed_mob))
			return
	pushed_mob.Move(src.loc)
	if(added_passtable)
		pushed_mob.pass_flags &= ~PASSTABLE
	if(pushed_mob.loc != loc) //Something prevented the tabling
		return
	pushed_mob.Knockdown(30)
	pushed_mob.apply_damage(10, BRUTE)
	pushed_mob.stamina.adjust(-40)
	if(user.mind?.martial_art.smashes_tables && user.mind?.martial_art.can_use(user))
		deconstruct(FALSE)
	playsound(pushed_mob, 'sound/effects/tableslam.ogg', 90, TRUE)
	pushed_mob.visible_message(span_danger("[user] slams [pushed_mob] onto \the [src]!"), \
								span_userdanger("[user] slams you onto \the [src]!"))
	log_combat(user, pushed_mob, "tabled", null, "onto [src]")

/obj/structure/table/proc/tablelimbsmash(mob/living/user, mob/living/pushed_mob)
	var/obj/item/bodypart/banged_limb = pushed_mob.get_bodypart(BODY_ZONE_HEAD)
	if(!banged_limb)
		return

	var/blocked = pushed_mob.run_armor_check(BODY_ZONE_HEAD, BLUNT)
	pushed_mob.apply_damage(30, BRUTE, BODY_ZONE_HEAD, blocked)
	if (prob(30 * ((100-blocked)/100)))
		pushed_mob.Knockdown(10 SECONDS)

	pushed_mob.stamina.adjust(-60)
	take_damage(50)
	if(user.mind?.martial_art.smashes_tables && user.mind?.martial_art.can_use(user))
		deconstruct(FALSE)

	playsound(pushed_mob, 'sound/items/trayhit1.ogg', 70, TRUE)
	pushed_mob.visible_message(
		span_danger("<b>[user]</b> smashes <b>[pushed_mob]</b>'s [banged_limb.plaintext_zone] against \the [src]!"),
	)
	log_combat(user, pushed_mob, "head slammed", null, "against [src]")

/obj/structure/table/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	if((flags_1 & NODECONSTRUCT_1) || !deconstruction_ready)
		return FALSE

	to_chat(user, span_notice("You start disassembling [src]..."))
	if(tool.use_tool(src, user, 2 SECONDS, volume=50))
		deconstruct(TRUE)

	return ITEM_INTERACT_SUCCESS

/obj/structure/table/wrench_act_secondary(mob/living/user, obj/item/tool)
	if((flags_1 & NODECONSTRUCT_1) || !deconstruction_ready)
		return NONE

	to_chat(user, span_notice("You start deconstructing [src]..."))

	if(tool.use_tool(src, user, 4 SECONDS, volume=50))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct(TRUE, 1)

	return ITEM_INTERACT_SUCCESS

// This extends base item interaction because tables default to blocking 99% of interactions
/obj/structure/table/base_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(.)
		return .

	if(is_flipped())
		return .

	if(istype(tool, /obj/item/toy/cards/deck))
		. = deck_interact(user, tool, modifiers, !!LAZYACCESS(modifiers, RIGHT_CLICK))

	else if(istype(tool, /obj/item/storage/bag/tray))
		. = tray_interact(user, tool, modifiers)

	else if(istype(tool, /obj/item/riding_offhand))
		. = riding_interact(user, tool, modifiers)

	// Continue to placing if we don't do anything else
	if(.)
		return .

	if(!user.combat_mode || (tool.item_flags & NOBLUDGEON))
		return place_item(user, tool, modifiers)

	return NONE

/obj/structure/table/proc/place_item(mob/living/user, obj/item/I, list/modifiers)
	if(!user.transferItemToLoc(I, drop_location(), silent = FALSE))
		return ITEM_INTERACT_BLOCKING

	//Center the icon where the user clicked.
	if(LAZYACCESS(modifiers, ICON_X) && LAZYACCESS(modifiers, ICON_Y))
		var/list/center = I.get_icon_center()
		var/half_icon_width = world.icon_size / 2

		var/x_offset = center["x"] - half_icon_width
		var/y_offset = center["y"] - half_icon_width

		var/x_diff = (text2num(modifiers[ICON_X]) - half_icon_width)
		var/y_diff = (text2num(modifiers[ICON_Y]) - half_icon_width)

		var/list/bounds = get_placable_bounds()
		var/new_x = clamp(pixel_x + x_diff, bounds["x1"] - half_icon_width, bounds["x2"] - half_icon_width)
		var/new_y = clamp(pixel_y + y_diff, bounds["y1"] - half_icon_width, bounds["y2"] - half_icon_width)

		I.pixel_x = new_x + x_offset
		I.pixel_y = new_y + y_offset

	AfterPutItemOnTable(I, user)
	return ITEM_INTERACT_SUCCESS

/obj/structure/table/proc/tray_interact(mob/living/user, obj/item/storage/bag/tray/tray, list/modifiers)
	if(!length(tray.contents)) // If the tray isn't empty
		return NONE // If the tray IS empty, continue on (tray will be placed on the table like other items)

	for(var/obj/item/I in tray.contents)
		AfterPutItemOnTable(I, user)

	tray.atom_storage.remove_all(drop_location())
	user.visible_message(span_notice("[user] empties [tray] on [src]."))
	return ITEM_INTERACT_SUCCESS

/obj/structure/table/proc/deck_interact(mob/living/user, obj/item/toy/cards/deck/deck, list/modifiers, flip)
	if(!deck.wielded)
		return NONE

	// deal a card facedown on the table
	var/obj/item/toy/singlecard/card = deck.draw(user)
	if(!card)
		return ITEM_INTERACT_BLOCKING

	if(flip)
		card.Flip()

	return place_item(user, card, modifiers)

/obj/structure/table/proc/riding_interact(mob/living/user, obj/item/riding_offhand/riding_item, list/modifiers)
	var/mob/living/carried_mob = riding_item.rider
	if(carried_mob == user) //Piggyback user.
		return NONE

	if(user.combat_mode)
		user.unbuckle_mob(carried_mob)
		tablelimbsmash(user, carried_mob)
		return ITEM_INTERACT_SUCCESS

	var/tableplace_delay = 3.5 SECONDS
	var/skills_space = ""
	if(HAS_TRAIT(user, TRAIT_QUICKER_CARRY))
		tableplace_delay = 2 SECONDS
		skills_space = " expertly"

	else if(HAS_TRAIT(user, TRAIT_QUICK_CARRY))
		tableplace_delay = 2.75 SECONDS
		skills_space = " quickly"

		carried_mob.visible_message(
			span_notice("<b>[user]</b> begins to[skills_space] place <b>[carried_mob]</b> onto [src]..."),
		)

	if(!do_after(user, carried_mob, tableplace_delay, DO_PUBLIC))
		return ITEM_INTERACT_BLOCKING

	user.unbuckle_mob(carried_mob)
	tableplace(user, carried_mob)
	return ITEM_INTERACT_SUCCESS

/obj/structure/table/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(istype(held_item, /obj/item/toy/cards/deck))
		var/obj/item/toy/cards/deck/dealer_deck = held_item
		if(dealer_deck.wielded)
			context[SCREENTIP_CONTEXT_LMB] = "Deal card"
			context[SCREENTIP_CONTEXT_RMB] = "Deal card faceup"
			return CONTEXTUAL_SCREENTIP_SET
	return NONE

/obj/structure/table/proc/AfterPutItemOnTable(obj/item/I, mob/living/user)
	return

/obj/structure/table/deconstruct(disassembled = TRUE, wrench_disassembly = 0)
	if(!(flags_1 & NODECONSTRUCT_1))
		var/turf/T = get_turf(src)
		if(buildstack)
			new buildstack(T, buildstackamount)
		else
			for(var/i in custom_materials)
				var/datum/material/M = i
				new M.sheet_type(T, FLOOR(custom_materials[M] / MINERAL_MATERIAL_AMOUNT, 1))
		if(!wrench_disassembly)
			new frame(T)
		else
			new framestack(T, framestackamount)
	qdel(src)

/obj/structure/table/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_DECONSTRUCT)
			return list("mode" = RCD_DECONSTRUCT, "delay" = 24, "cost" = 16)
	return FALSE

/obj/structure/table/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_DECONSTRUCT)
			to_chat(user, span_notice("You deconstruct the table."))
			qdel(src)
			return TRUE
	return FALSE

/obj/structure/table/proc/table_carbon(datum/source, mob/living/carbon/shover, mob/living/carbon/target, shove_blocked)
	SIGNAL_HANDLER
	if(!shove_blocked)
		return
	target.Knockdown(SHOVE_KNOCKDOWN_TABLE)
	target.visible_message(span_danger("[shover.name] shoves [target.name] onto \the [src]!"),
		span_userdanger("You're shoved onto \the [src] by [shover.name]!"), span_hear("You hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, src)
	to_chat(shover, span_danger("You shove [target.name] onto \the [src]!"))
	target.throw_at(src, 1, 1, null, FALSE) //1 speed throws with no spin are basically just forcemoves with a hard collision check
	log_combat(src, target, "shoved", "onto [src] (table)")
	return COMSIG_CARBON_SHOVE_HANDLED

/// Returns a list of placable bounds, see placable_bounds
/obj/structure/table/proc/get_placable_bounds()
	var/list/bounds = params2list(placable_bounds)
	for(var/key in bounds)
		bounds[key] = text2num(bounds[key])
	return bounds

/obj/structure/table/greyscale
	icon = 'icons/obj/smooth_structures/table_greyscale.dmi'
	icon_state = "table_greyscale-0"
	base_icon_state = "table_greyscale"
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	buildstack = null //No buildstack, so generate from mat datums

///Table on wheels
/obj/structure/table/rolling
	name = "Rolling table"
	desc = "An NT brand \"Rolly poly\" rolling table. It can and will move."
	anchored = FALSE
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	icon = 'icons/obj/smooth_structures/rollingtable.dmi'
	icon_state = "rollingtable"
	var/list/attached_items = list()

/obj/structure/table/rolling/AfterPutItemOnTable(obj/item/I, mob/living/user)
	. = ..()
	attached_items += I
	RegisterSignal(I, COMSIG_MOVABLE_MOVED, PROC_REF(RemoveItemFromTable)) //Listen for the pickup event, unregister on pick-up so we aren't moved

/obj/structure/table/rolling/proc/RemoveItemFromTable(datum/source, newloc, dir)
	SIGNAL_HANDLER

	if(newloc != loc) //Did we not move with the table? because that shit's ok
		return FALSE
	attached_items -= source
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

/obj/structure/table/rolling/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(!loc)
		return
	for(var/mob/living/living_mob in old_loc.contents)//Kidnap everyone on top
		living_mob.forceMove(loc)
	for(var/atom/movable/attached_movable as anything in attached_items)
		if(!attached_movable.Move(loc))
			RemoveItemFromTable(attached_movable, attached_movable.loc)

/*
 * Glass tables
 */
TYPEINFO_DEF(/obj/structure/table/glass)
	default_armor = list(BLUNT = 0, PUNCTURE = 0, SLASH = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 80, ACID = 100)
	default_materials = list(/datum/material/glass = 2000)

/obj/structure/table/glass
	name = "glass table"
	desc = "What did I say about leaning on the glass tables? Now you need surgery."
	icon = 'icons/obj/smooth_structures/glass_table.dmi'
	icon_state = "glass_table-0"
	base_icon_state = "glass_table"
	buildstack = /obj/item/stack/sheet/glass
	smoothing_groups = SMOOTH_GROUP_GLASS_TABLES
	canSmoothWith = SMOOTH_GROUP_GLASS_TABLES
	max_integrity = 70
	resistance_flags = ACID_PROOF
	var/glass_shard_type = /obj/item/shard

/obj/structure/table/glass/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(. || !is_flipped())
		return
	if(mover.pass_flags & PASSGLASS)
		return TRUE

/obj/structure/table/glass/check_exit(datum/source, atom/movable/leaving, direction)
	. = ..()
	if(. || !is_flipped())
		return
	if(leaving.pass_flags & PASSGLASS)
		return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/table/glass/on_crossed(atom/movable/crossed_by, oldloc)
	. = ..()
	if(flags_1 & NODECONSTRUCT_1)
		return
	if(!isliving(crossed_by))
		return
	// Don't break if they're just flying past
	if(crossed_by.throwing)
		addtimer(CALLBACK(src, PROC_REF(throw_check), crossed_by), 5)
	else
		check_break(crossed_by)

/obj/structure/table/glass/proc/throw_check(mob/living/M)
	if(M.loc == get_turf(src))
		check_break(M)

/obj/structure/table/glass/proc/check_break(mob/living/M)
	if(M.has_gravity() && M.mob_size > MOB_SIZE_SMALL && !(M.movement_type & FLYING))
		table_shatter(M)

/obj/structure/table/glass/proc/table_shatter(mob/living/victim)
	visible_message(span_warning("[src] breaks!"),
		span_danger("You hear breaking glass."))

	playsound(loc, SFX_SHATTER, 50, TRUE)

	new frame(loc)

	var/obj/item/shard/shard = new glass_shard_type(loc)
	shard.throw_impact(victim)

	victim.Paralyze(100)
	qdel(src)

/obj/structure/table/glass/deconstruct(disassembled = TRUE, wrench_disassembly = 0)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(disassembled)
			..()
			return
		else
			var/turf/T = get_turf(src)
			playsound(T, SFX_SHATTER, 50, TRUE)
			new frame(loc)
			var/obj/item/shard = new glass_shard_type(loc)
			shard.color = color
	qdel(src)

/obj/structure/table/glass/narsie_act()
	color = NARSIE_WINDOW_COLOUR

TYPEINFO_DEF(/obj/structure/table/glass/plasmaglass)
	default_materials = list(/datum/material/alloy/plasmaglass = 2000)

/obj/structure/table/glass/plasmaglass
	name = "plasma glass table"
	desc = "Someone thought this was a good idea."
	icon = 'icons/obj/smooth_structures/plasmaglass_table.dmi'
	icon_state = "plasmaglass_table-0"
	base_icon_state = "plasmaglass_table"
	buildstack = /obj/item/stack/sheet/plasmaglass
	max_integrity = 100
	glass_shard_type = /obj/item/shard/plasma

/*
 * Wooden tables
 */

/obj/structure/table/wood
	name = "wooden table"
	desc = "Do not apply fire to this. Rumour says it burns easily."
	icon = 'icons/obj/smooth_structures/wood_table.dmi'
	icon_state = "wood_table-0"
	base_icon_state = "wood_table"
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/sheet/mineral/wood
	resistance_flags = FLAMMABLE
	max_integrity = 70
	smoothing_groups = SMOOTH_GROUP_WOOD_TABLES //Don't smooth with SMOOTH_GROUP_TABLES
	canSmoothWith = SMOOTH_GROUP_WOOD_TABLES

/obj/structure/table/wood/narsie_act(total_override = TRUE)
	if(!total_override)
		..()

/obj/structure/table/wood/poker //No specialties, Just a mapping object.
	name = "gambling table"
	desc = "A seedy table for seedy dealings in seedy places."
	icon = 'icons/obj/smooth_structures/poker_table.dmi'
	icon_state = "poker_table-0"
	base_icon_state = "poker_table"
	buildstack = /obj/item/stack/tile/carpet

/obj/structure/table/wood/poker/narsie_act()
	..(FALSE)

/obj/structure/table/wood/fancy
	name = "fancy table"
	desc = "A standard metal table frame covered with an amazingly fancy, patterned cloth."
	icon = 'icons/obj/structures.dmi'
	icon_state = "fancy_table"
	base_icon_state = "fancy_table"
	frame = /obj/structure/table_frame
	framestack = /obj/item/stack/rods
	buildstack = /obj/item/stack/tile/carpet
	smoothing_groups = SMOOTH_GROUP_FANCY_WOOD_TABLES //Don't smooth with SMOOTH_GROUP_TABLES or SMOOTH_GROUP_WOOD_TABLES
	canSmoothWith = SMOOTH_GROUP_FANCY_WOOD_TABLES // see Initialize()

/obj/structure/table/wood/fancy/black
	icon_state = "fancy_table_black-0"
	base_icon_state = "fancy_table_black"
	buildstack = /obj/item/stack/tile/carpet/black
	icon = 'icons/obj/smooth_structures/fancy_table_black.dmi'

/obj/structure/table/wood/fancy/blue
	icon_state = "fancy_table_blue-0"
	base_icon_state = "fancy_table_blue"
	buildstack = /obj/item/stack/tile/carpet/blue
	icon = 'icons/obj/smooth_structures/fancy_table_blue.dmi'

/obj/structure/table/wood/fancy/cyan
	icon_state = "fancy_table_cyan-0"
	base_icon_state = "fancy_table_cyan"
	buildstack = /obj/item/stack/tile/carpet/cyan
	icon = 'icons/obj/smooth_structures/fancy_table_cyan.dmi'

/obj/structure/table/wood/fancy/green
	icon_state = "fancy_table_green-0"
	base_icon_state = "fancy_table_green"
	buildstack = /obj/item/stack/tile/carpet/green
	icon = 'icons/obj/smooth_structures/fancy_table_green.dmi'

/obj/structure/table/wood/fancy/orange
	icon_state = "fancy_table_orange-0"
	base_icon_state = "fancy_table_orange"
	buildstack = /obj/item/stack/tile/carpet/orange
	icon = 'icons/obj/smooth_structures/fancy_table_orange.dmi'

/obj/structure/table/wood/fancy/purple
	icon_state = "fancy_table_purple-0"
	base_icon_state = "fancy_table_purple"
	buildstack = /obj/item/stack/tile/carpet/purple
	icon = 'icons/obj/smooth_structures/fancy_table_purple.dmi'

/obj/structure/table/wood/fancy/red
	icon_state = "fancy_table_red-0"
	base_icon_state = "fancy_table_red"
	buildstack = /obj/item/stack/tile/carpet/red
	icon = 'icons/obj/smooth_structures/fancy_table_red.dmi'

/obj/structure/table/wood/fancy/royalblack
	icon_state = "fancy_table_royalblack-0"
	base_icon_state = "fancy_table_royalblack"
	buildstack = /obj/item/stack/tile/carpet/royalblack
	icon = 'icons/obj/smooth_structures/fancy_table_royalblack.dmi'

/obj/structure/table/wood/fancy/royalblue
	icon_state = "fancy_table_royalblue-0"
	base_icon_state = "fancy_table_royalblue"
	buildstack = /obj/item/stack/tile/carpet/royalblue
	icon = 'icons/obj/smooth_structures/fancy_table_royalblue.dmi'

/*
 * Reinforced tables
 */
TYPEINFO_DEF(/obj/structure/table/reinforced)
	default_armor = list(BLUNT = 10, PUNCTURE = 30, SLASH = 0, LASER = 30, ENERGY = 100, BOMB = 20, BIO = 0, FIRE = 80, ACID = 70)

/obj/structure/table/reinforced
	name = "reinforced table"
	desc = "A reinforced version of the four legged table."
	icon = 'icons/obj/smooth_structures/reinforced_table.dmi'
	icon_state = "reinforced_table-0"
	base_icon_state = "reinforced_table"
	deconstruction_ready = 0
	buildstack = /obj/item/stack/sheet/plasteel
	max_integrity = 200
	integrity_failure = 0.25
	flipped = -1

/obj/structure/table/reinforced/deconstruction_hints(mob/user)
	if(deconstruction_ready)
		return span_notice("The top cover has been <i>welded</i> loose and the main frame's <b>bolts</b> are exposed.")
	else
		return span_notice("The top cover is firmly <b>welded</b> on.")

/obj/structure/table/reinforced/attackby_secondary(obj/item/weapon, mob/user, params)
	if(weapon.tool_behaviour == TOOL_WELDER)
		if(weapon.tool_start_check(user, amount = 0))
			if(deconstruction_ready)
				to_chat(user, span_notice("You start strengthening the reinforced table..."))
				if (weapon.use_tool(src, user, 50, volume = 50))
					to_chat(user, span_notice("You strengthen the table."))
					deconstruction_ready = FALSE
			else
				to_chat(user, span_notice("You start weakening the reinforced table..."))
				if (weapon.use_tool(src, user, 50, volume = 50))
					to_chat(user, span_notice("You weaken the table."))
					deconstruction_ready = TRUE
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	else
		. = ..()

/obj/structure/table/bronze
	name = "bronze table"
	desc = "A solid table made out of bronze."
	icon = 'icons/obj/smooth_structures/brass_table.dmi'
	icon_state = "brass_table-0"
	base_icon_state = "brass_table"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	buildstack = /obj/item/stack/sheet/bronze
	smoothing_groups = SMOOTH_GROUP_BRONZE_TABLES //Don't smooth with SMOOTH_GROUP_TABLES
	canSmoothWith = SMOOTH_GROUP_BRONZE_TABLES

/obj/structure/table/bronze/tablepush(mob/living/user, mob/living/pushed_mob)
	..()
	playsound(src, 'sound/magic/clockwork/fellowship_armory.ogg', 50, TRUE)

TYPEINFO_DEF(/obj/structure/table/reinforced/rglass)
	default_materials = list(/datum/material/glass = 2000, /datum/material/iron = 2000)

/obj/structure/table/reinforced/rglass
	name = "reinforced glass table"
	desc = "A reinforced version of the glass table."
	icon = 'icons/obj/smooth_structures/rglass_table.dmi'
	icon_state = "rglass_table-0"
	base_icon_state = "rglass_table"
	buildstack = /obj/item/stack/sheet/rglass
	max_integrity = 150

TYPEINFO_DEF(/obj/structure/table/reinforced/plasmarglass)
	default_materials = list(/datum/material/alloy/plasmaglass = 2000, /datum/material/iron = 2000)

/obj/structure/table/reinforced/plasmarglass
	name = "reinforced plasma glass table"
	desc = "A reinforced version of the plasma glass table."
	icon = 'icons/obj/smooth_structures/rplasmaglass_table.dmi'
	icon_state = "rplasmaglass_table-0"
	base_icon_state = "rplasmaglass_table"
	buildstack = /obj/item/stack/sheet/plasmarglass

TYPEINFO_DEF(/obj/structure/table/reinforced/titaniumglass)
	default_materials = list(/datum/material/alloy/titaniumglass = 2000)

/obj/structure/table/reinforced/titaniumglass
	name = "titanium glass table"
	desc = "A titanium reinforced glass table, with a fresh coat of NT white paint."
	icon = 'icons/obj/smooth_structures/titaniumglass_table.dmi'
	icon_state = "titaniumglass_table-o"
	base_icon_state = "titaniumglass_table"
	buildstack = /obj/item/stack/sheet/titaniumglass
	max_integrity = 250

TYPEINFO_DEF(/obj/structure/table/reinforced/plastitaniumglass)
	default_materials = list(/datum/material/alloy/plastitaniumglass = 2000)

/obj/structure/table/reinforced/plastitaniumglass
	name = "plastitanium glass table"
	desc = "A table made of titanium reinforced silica-plasma composite. About as durable as it sounds."
	icon = 'icons/obj/smooth_structures/plastitaniumglass_table.dmi'
	icon_state = "plastitaniumglass_table-0"
	base_icon_state = "plastitaniumglass_table"
	buildstack = /obj/item/stack/sheet/plastitaniumglass
	max_integrity = 300

/*
 * Surgery Tables
 */

TYPEINFO_DEF(/obj/structure/table/optable)
	default_materials = list(/datum/material/silver = 2000)

/obj/structure/table/optable
	name = "operating table"
	desc = "Used for advanced medical procedures."
	icon = 'icons/obj/surgery.dmi'
	base_icon_state = "optable"
	icon_state = "optable"
	buildstack = /obj/item/stack/sheet/mineral/silver
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	can_buckle = 1
	buckle_lying = NO_BUCKLE_LYING
	buckle_requires_restraints = TRUE
	flipped = -1

	var/obj/machinery/vitals_monitor/connected_monitor
	var/mob/living/carbon/human/patient = null

/obj/structure/table/optable/Destroy()
	if(patient)
		set_patient(null)
	if(connected_monitor)
		connected_monitor.set_optable(null)
		connected_monitor = null
	return ..()

/obj/structure/table/optable/MouseDroppedOn(atom/dropping, mob/living/user)
	if(!iscarbon(dropping))
		return ..()

	if(dropping.loc == loc)
		set_patient(dropping)
	else
		return ..()

/obj/structure/table/optable/on_uncrossed(datum/source, atom/movable/gone, direction)
	. = ..()
	if(gone == patient)
		set_patient(null)

/obj/structure/table/optable/tableplace(mob/living/user, mob/living/pushed_mob)
	. = ..()
	pushed_mob.set_resting(TRUE, TRUE)
	get_patient()

/obj/structure/table/optable/tablepush(mob/living/user, mob/living/pushed_mob)
	. = ..()
	pushed_mob.set_resting(TRUE, TRUE)
	get_patient()

/obj/structure/table/optable/proc/get_patient()
	var/mob/living/carbon/M = locate(/mob/living/carbon) in loc
	if(M)
		if(M.body_position == LYING_DOWN)
			set_patient(M)
	else
		set_patient(null)

/obj/structure/table/optable/proc/set_patient(new_patient)
	if(patient)
		REMOVE_TRAIT(patient, TRAIT_CANNOTFACE, OPTABLE_TRAIT)
		UnregisterSignal(patient, COMSIG_PARENT_QDELETING)
	patient = new_patient
	if(patient)
		ADD_TRAIT(patient, TRAIT_CANNOTFACE, OPTABLE_TRAIT)
		patient.set_lying_angle(LYING_ANGLE_EAST)
		patient.setDir(SOUTH)
		RegisterSignal(patient, COMSIG_PARENT_QDELETING, PROC_REF(patient_deleted))

	if(connected_monitor)
		connected_monitor.update_appearance(UPDATE_OVERLAYS)

/obj/structure/table/optable/proc/patient_deleted(datum/source)
	SIGNAL_HANDLER
	set_patient(null)

/obj/structure/table/optable/proc/check_eligible_patient()
	get_patient()
	if(!patient)
		return FALSE
	if(ishuman(patient))
		return TRUE
	return FALSE

/*
 * Racks
 */
/obj/structure/rack
	name = "rack"
	desc = "Different from the Middle Ages version."
	icon = 'icons/obj/objects.dmi'
	icon_state = "rack"
	layer = TABLE_LAYER
	density = TRUE
	anchored = TRUE
	pass_flags_self = LETPASSTHROW //You can throw objects over this, despite it's density.
	max_integrity = 20

/obj/structure/rack/examine(mob/user)
	. = ..()
	. += span_notice("It's held together by a couple of <b>bolts</b>.")

/obj/structure/rack/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return TRUE

/obj/structure/rack/MouseDroppedOn(obj/O, mob/user)
	. = ..()
	if ((!( istype(O, /obj/item) ) || user.get_active_held_item() != O))
		return
	if(!user.dropItemToGround(O))
		return
	if(O.loc != src.loc)
		step(O, get_dir(O, src))

/obj/structure/rack/attackby(obj/item/W, mob/living/user, params)
	var/list/modifiers = params2list(params)
	if (W.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1) && LAZYACCESS(modifiers, RIGHT_CLICK))
		W.play_tool_sound(src)
		deconstruct(TRUE)
		return
	if(user.combat_mode)
		return ..()
	if(user.transferItemToLoc(W, drop_location()))
		return 1

/obj/structure/rack/attack_paw(mob/living/user, list/modifiers)
	attack_hand(user, modifiers)

/obj/structure/rack/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.body_position == LYING_DOWN || user.usable_legs < 2)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	user.do_attack_animation(src, ATTACK_EFFECT_KICK)
	user.visible_message(span_danger("[user] kicks [src]."), null, null, COMBAT_MESSAGE_RANGE)
	take_damage(rand(4,8), BRUTE, BLUNT, 1)

/obj/structure/rack/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/items/dodgeball.ogg', 80, TRUE)
			else
				playsound(loc, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(loc, 'sound/items/welder.ogg', 40, TRUE)

/*
 * Rack destruction
 */

/obj/structure/rack/deconstruct(disassembled = TRUE)
	if(!(flags_1&NODECONSTRUCT_1))
		set_density(FALSE)
		var/obj/item/rack_parts/newparts = new(loc)
		transfer_fingerprints_to(newparts)
	qdel(src)


/*
 * Rack Parts
 */

TYPEINFO_DEF(/obj/item/rack_parts)
	default_materials = list(/datum/material/iron=2000)

/obj/item/rack_parts
	name = "rack parts"
	desc = "Parts of a rack."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "rack_parts"
	flags_1 = CONDUCT_1
	var/building = FALSE

/obj/item/rack_parts/attackby(obj/item/W, mob/user, params)
	if (W.tool_behaviour == TOOL_WRENCH)
		new /obj/item/stack/sheet/iron(user.loc)
		qdel(src)
	else
		. = ..()

/obj/item/rack_parts/attack_self(mob/user)
	if(building)
		return
	building = TRUE
	to_chat(user, span_notice("You start constructing a rack..."))
	if(do_after(user, user, 50, DO_PUBLIC, progress=TRUE, display = src))
		if(!user.temporarilyRemoveItemFromInventory(src))
			return
		var/obj/structure/rack/R = new /obj/structure/rack(user.loc)
		user.visible_message("<span class='notice'>[user] assembles \a [R].\
			</span>", span_notice("You assemble \a [R]."))
		R.add_fingerprint(user)
		qdel(src)
	building = FALSE
