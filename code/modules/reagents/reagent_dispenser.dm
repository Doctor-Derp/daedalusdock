/obj/structure/reagent_dispensers
	name = "Dispenser"
	desc = "..."
	icon = 'icons/obj/chemical_tanks.dmi'
	icon_state = "water"
	density = TRUE
	anchored = FALSE
	//pressure_resistance = 2*ONE_ATMOSPHERE
	max_integrity = 300
	///In units, how much the dispenser can hold
	var/tank_volume = 1000
	///The ID of the reagent that the dispenser uses
	var/reagent_id = /datum/reagent/water

/obj/structure/reagent_dispensers/Initialize(mapload)
	. = ..()
	if(icon_state == "water" && SSevents.holidays?[APRIL_FOOLS])
		icon_state = "water_fools"

/obj/structure/reagent_dispensers/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(. && atom_integrity > 0)
		if(tank_volume && (damage_flag == PUNCTURE || damage_flag == LASER))
			boom()

/obj/structure/reagent_dispensers/attackby(obj/item/W, mob/user, params)
	if(W.is_refillable())
		return FALSE //so we can refill them via their afterattack.
	else
		return ..()

/obj/structure/reagent_dispensers/Initialize(mapload)
	create_reagents(tank_volume, DRAINABLE | AMOUNT_VISIBLE)
	if(reagent_id)
		reagents.add_reagent(reagent_id, tank_volume)
	. = ..()

/obj/structure/reagent_dispensers/proc/boom()
	visible_message(span_danger("\The [src] ruptures!"))
	chem_splash(loc, null, 5, list(reagents))
	qdel(src)

/obj/structure/reagent_dispensers/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(!disassembled)
			boom()
	else
		qdel(src)

/obj/structure/reagent_dispensers/watertank
	name = "water tank"
	desc = "A water tank."
	icon_state = "water"

/obj/structure/reagent_dispensers/watertank/high
	name = "high-capacity water tank"
	desc = "A highly pressurized water tank made to hold gargantuan amounts of water."
	icon_state = "water_high" //I was gonna clean my room...
	tank_volume = 100000

/obj/structure/reagent_dispensers/foamtank
	name = "firefighting foam tank"
	desc = "A tank full of firefighting foam."
	icon_state = "foam"
	reagent_id = /datum/reagent/firefighting_foam
	tank_volume = 500

/obj/structure/reagent_dispensers/fueltank
	name = "fuel tank"
	desc = "A tank full of industrial welding fuel. Do not consume."
	icon_state = "fuel"
	reagent_id = /datum/reagent/fuel

/obj/structure/reagent_dispensers/fueltank/Initialize(mapload)
	. = ..()

	if(SSevents.holidays?[APRIL_FOOLS])
		icon_state = "fuel_fools"

/obj/structure/reagent_dispensers/fueltank/boom()
	var/turf/explode_turf = get_turf(src)
	qdel(src)
	explosion(explode_turf, heavy_impact_range = 1, light_impact_range = 5, flame_range = 5)

/obj/structure/reagent_dispensers/fueltank/blob_act(obj/structure/blob/B)
	boom()

/obj/structure/reagent_dispensers/fueltank/ex_act()
	boom()

/obj/structure/reagent_dispensers/fueltank/fire_act(exposed_temperature, exposed_volume, turf/adjacent)
	boom()

/obj/structure/reagent_dispensers/fueltank/zap_act(power, zap_flags)
	. = ..() //extend the zap
	if(ZAP_OBJ_DAMAGE & zap_flags)
		boom()

/obj/structure/reagent_dispensers/fueltank/bullet_act(obj/projectile/P)
	. = ..()
	if(!QDELETED(src)) //wasn't deleted by the projectile's effects.
		if(!P.nodamage && ((P.damage_type == BURN) || (P.damage_type == BRUTE)))
			log_bomber(P.firer, "detonated a", src, "via projectile")
			boom()

/obj/structure/reagent_dispensers/fueltank/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_WELDER)
		if(!reagents.has_reagent(/datum/reagent/fuel))
			to_chat(user, span_warning("[src] is out of fuel!"))
			return
		var/obj/item/weldingtool/W = I
		if(istype(W) && !W.welding)
			if(W.reagents.has_reagent(/datum/reagent/fuel, W.max_fuel))
				to_chat(user, span_warning("Your [W.name] is already full!"))
				return
			reagents.trans_to(W, W.max_fuel, transfered_by = user)
			user.visible_message(span_notice("[user] refills [user.p_their()] [W.name]."), span_notice("You refill [W]."))
			playsound(src, 'sound/effects/refill.ogg', 50, TRUE)
			W.update_appearance()
		else
			user.visible_message(span_danger("[user] catastrophically fails at refilling [user.p_their()] [I.name]!"), span_userdanger("That was stupid of you."))
			log_bomber(user, "detonated a", src, "via welding tool")
			boom()
		return
	return ..()

/obj/structure/reagent_dispensers/fueltank/large
	name = "high capacity fuel tank"
	desc = "A tank full of a high quantity of welding fuel. Keep away from open flames."
	icon_state = "fuel_high"
	tank_volume = 5000

/obj/structure/reagent_dispensers/fueltank/large/boom()
	if(QDELETED(src))
		return
	explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 7, flame_range = 12)
	qdel(src)

/// Wall mounted dispeners, like pepper spray or virus food. Not a normal tank.
/obj/structure/reagent_dispensers/wall
	anchored = TRUE
	density = FALSE

/obj/structure/reagent_dispensers/wall/peppertank
	name = "pepper spray refiller"
	desc = "Contains condensed capsaicin for use in law \"enforcement.\""
	icon_state = "pepper"
	reagent_id = /datum/reagent/consumable/condensedcapsaicin

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/reagent_dispensers/wall/peppertank, 30)

/obj/structure/reagent_dispensers/wall/peppertank/Initialize(mapload)
	. = ..()
	if(prob(1))
		desc = "IT'S PEPPER TIME, BITCH!"

/obj/structure/reagent_dispensers/water_cooler
	name = "liquid cooler"
	desc = "A machine that dispenses liquid to drink."
	icon = 'icons/obj/vending.dmi'
	icon_state = "water_cooler"
	anchored = TRUE
	tank_volume = 500
	var/paper_cups = 25 //Paper cups left from the cooler

/obj/structure/reagent_dispensers/water_cooler/examine(mob/user)
	. = ..()
	if (paper_cups > 1)
		. += "There are [paper_cups] paper cups left."
	else if (paper_cups == 1)
		. += "There is one paper cup left."
	else
		. += "There are no paper cups left."

/obj/structure/reagent_dispensers/water_cooler/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!paper_cups)
		to_chat(user, span_warning("There aren't any cups left!"))
		return
	user.visible_message(span_notice("[user] takes a cup from [src]."), span_notice("You take a paper cup from [src]."))
	var/obj/item/reagent_containers/cup/glass/sillycup/S = new(get_turf(src))
	user.put_in_hands(S)
	paper_cups--

/obj/structure/reagent_dispensers/beerkeg
	name = "beer keg"
	desc = "Beer is liquid bread, it's good for you..."
	icon_state = "beer"
	reagent_id = /datum/reagent/consumable/ethanol/beer

/obj/structure/reagent_dispensers/beerkeg/blob_act(obj/structure/blob/B)
	explosion(src, heavy_impact_range = 3, light_impact_range = 5, flame_range = 10, flash_range = 7)
	if(!QDELETED(src))
		qdel(src)

/obj/structure/reagent_dispensers/wall/virusfood
	name = "virus food dispenser"
	desc = "A dispenser of low-potency virus mutagenic."
	icon_state = "virus_food"
	reagent_id = /datum/reagent/consumable/virus_food

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/reagent_dispensers/wall/virusfood, 30)

/obj/structure/reagent_dispensers/cooking_oil
	name = "vat of cooking oil"
	desc = "A huge metal vat with a tap on the front. Filled with cooking oil for use in frying food."
	icon_state = "vat"
	anchored = TRUE
	reagent_id = /datum/reagent/consumable/cooking_oil

/obj/structure/reagent_dispensers/servingdish
	name = "serving dish"
	desc = "A dish full of food slop for your bowl."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "serving"
	anchored = TRUE
	reagent_id = /datum/reagent/consumable/nutraslop
