////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/cup/glass
	name = "drink"
	desc = "yummy"
	icon = 'icons/obj/drinks.dmi'
	icon_state = null
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	reagent_flags = OPENCONTAINER | DUNKABLE
	possible_transfer_amounts = list(5,10,15,20,25,30,50)
	volume = 50
	resistance_flags = NONE

/*
 * On accidental consumption, make sure the container is partially glass, and continue to the reagent_container proc
 */
/obj/item/reagent_containers/cup/glass/on_accidental_consumption(mob/living/carbon/M, mob/living/carbon/user, obj/item/source_item,  discover_after = TRUE)
	if(isGlass && !custom_materials)
		set_custom_materials(list(GET_MATERIAL_REF(/datum/material/glass) = 5))
	return ..()

/obj/item/reagent_containers/cup/glass/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!.) //if the bottle wasn't caught
		smash(hit_atom, throwingdatum?.thrower, TRUE)

/// Smashes the container
/obj/item/reagent_containers/cup/glass/proc/smash(atom/target, mob/thrower, ranged = FALSE, extra_bump = TRUE)
	if(!isGlass)
		return
	if(QDELING(src) || !target) //Invalid loc
		return
	if(bartender_check(target) && ranged)
		return

	SplashReagents(target, ranged, override_spillable = TRUE)

	var/obj/item/broken_bottle/B = new (loc)
	B.mimic_broken(src, target)

	if(prob(33))
		var/obj/item/shard/stab_with = new(drop_location())
		if(extra_bump)
			target.BumpedBy(stab_with)

	playsound(src, SFX_SHATTER, 70, TRUE)

	qdel(src)
	if(extra_bump)
		target.BumpedBy(B)

/obj/item/reagent_containers/cup/glass/bullet_act(obj/projectile/P)
	. = ..()
	if(!(P.nodamage) && P.damage_type == BRUTE && !QDELETED(src))
		var/atom/T = get_turf(src)
		smash(T)
		return

////////////////////////////////////////////////////////////////////////////////
/// Drinks. END
////////////////////////////////////////////////////////////////////////////////


TYPEINFO_DEF(/obj/item/reagent_containers/cup/glass/trophy)
	default_materials = list(/datum/material/iron=100)

/obj/item/reagent_containers/cup/glass/trophy
	name = "pewter cup"
	desc = "Everyone gets a trophy."
	icon_state = "pewter_cup"
	w_class = WEIGHT_CLASS_TINY
	force = 1
	throwforce = 1
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(5)
	volume = 5
	flags_1 = CONDUCT_1
	spillable = TRUE
	resistance_flags = FIRE_PROOF
	isGlass = FALSE

TYPEINFO_DEF(/obj/item/reagent_containers/cup/glass/trophy/gold_cup)
	default_materials = list(/datum/material/gold=1000)

/obj/item/reagent_containers/cup/glass/trophy/gold_cup
	name = "gold cup"
	desc = "You're winner!"
	icon_state = "golden_cup"
	w_class = WEIGHT_CLASS_BULKY
	force = 14
	throwforce = 10
	amount_per_transfer_from_this = 20
	volume = 150

TYPEINFO_DEF(/obj/item/reagent_containers/cup/glass/trophy/silver_cup)
	default_materials = list(/datum/material/silver=800)

/obj/item/reagent_containers/cup/glass/trophy/silver_cup
	name = "silver cup"
	desc = "Best loser!"
	icon_state = "silver_cup"
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	throwforce = 8
	amount_per_transfer_from_this = 15
	volume = 100


TYPEINFO_DEF(/obj/item/reagent_containers/cup/glass/trophy/bronze_cup)
	default_materials = list(/datum/material/iron=400)

/obj/item/reagent_containers/cup/glass/trophy/bronze_cup
	name = "bronze cup"
	desc = "At least you ranked!"
	icon_state = "bronze_cup"
	w_class = WEIGHT_CLASS_SMALL
	force = 5
	throwforce = 4
	amount_per_transfer_from_this = 10
	volume = 25

///////////////////////////////////////////////Drinks
//Notes by Darem: Drinks are simply containers that start preloaded. Unlike condiments, the contents can be ingested directly
// rather then having to add it to something else first. They should only contain liquids. They have a default container size of 50.
// Formatting is the same as food.

/obj/item/reagent_containers/cup/glass/coffee
	name = "robust coffee"
	desc = "Careful, the beverage you're about to enjoy is extremely hot."
	icon_state = "coffee"
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	spillable = TRUE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	drink_type = BREAKFAST

/obj/item/reagent_containers/cup/glass/ice
	name = "ice cup"
	desc = "Careful, cold ice, do not chew."
	custom_price = PAYCHECK_ASSISTANT * 0.4
	icon_state = "coffee"
	list_reagents = list(/datum/reagent/consumable/ice = 30)
	spillable = TRUE
	isGlass = FALSE

/obj/item/reagent_containers/cup/glass/ice/prison
	name = "dirty ice cup"
	desc = "Either the station's water supply is contaminated, or this machine actually vends lemon, chocolate, and cherry snow cones."
	list_reagents = list(/datum/reagent/consumable/ice = 25, /datum/reagent/liquidgibs = 5)

/obj/item/reagent_containers/cup/glass/dry_ramen
	name = "cup ramen"
	desc = "Just add 5ml of water, self heats! A taste that reminds you of your school years. Now new with salty flavour!"
	icon_state = "ramen"
	list_reagents = list(/datum/reagent/consumable/dry_ramen = 15, /datum/reagent/consumable/salt = 3)
	drink_type = GRAIN
	isGlass = FALSE
	custom_price = PAYCHECK_ASSISTANT * 0.4

TYPEINFO_DEF(/obj/item/reagent_containers/cup/glass/waterbottle)
	default_materials = list(/datum/material/plastic=1000)

/obj/item/reagent_containers/cup/glass/waterbottle
	name = "bottle of water"
	desc = "A bottle of water filled at an old Earth bottling facility."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "smallbottle"
	inhand_icon_state = "bottle"
	list_reagents = list(/datum/reagent/water = 49.5, /datum/reagent/fluorine = 0.5)//see desc, don't think about it too hard
	volume = 50
	amount_per_transfer_from_this = 10
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 80, 90)
	isGlass = FALSE
	// The 2 bottles have separate cap overlay icons because if the bottle falls over while bottle flipping the cap stays fucked on the moved overlay
	var/cap_icon_state = "bottle_cap_small"
	var/cap_on = TRUE
	var/cap_lost = FALSE
	var/mutable_appearance/cap_overlay
	var/flip_chance = 10
	custom_price = PAYCHECK_ASSISTANT * 0.5

/obj/item/reagent_containers/cup/glass/waterbottle/Initialize(mapload)
	. = ..()
	cap_overlay = mutable_appearance(icon, cap_icon_state)
	if(cap_on)
		spillable = FALSE
		update_appearance()

/obj/item/reagent_containers/cup/glass/waterbottle/update_overlays()
	. = ..()
	if(cap_on)
		. += cap_overlay

/obj/item/reagent_containers/cup/glass/waterbottle/examine(mob/user)
	. = ..()
	if(cap_lost)
		. += span_alert("The cap is missing.")
	else if(cap_on)
		. += span_info("The cap is on.")
	else
		. += span_alert("The cap has been taken off.")

/obj/item/reagent_containers/cup/glass/waterbottle/AltClick(mob/user)
	. = ..()
	if(cap_lost)
		to_chat(user, span_warning("The cap seems to be missing! Where did it go?"))
		return

	var/fumbled = HAS_TRAIT(user, TRAIT_CLUMSY) && prob(5)
	if(cap_on || fumbled)
		cap_on = FALSE
		spillable = TRUE
		animate(src, transform = null, time = 2, loop = 0)
		if(fumbled)
			to_chat(user, span_warning("You fumble with [src]'s cap! The cap falls onto the ground and simply vanishes. Where the hell did it go?"))
			cap_lost = TRUE
		else
			to_chat(user, span_notice("You remove the cap from [src]."))
	else
		cap_on = TRUE
		spillable = FALSE
		to_chat(user, span_notice("You put the cap on [src]."))
	update_appearance()

/obj/item/reagent_containers/cup/glass/waterbottle/is_refillable()
	if(cap_on)
		return FALSE
	. = ..()

/obj/item/reagent_containers/cup/glass/waterbottle/is_drainable()
	if(cap_on)
		return FALSE
	. = ..()

/obj/item/reagent_containers/cup/glass/waterbottle/attack(mob/target, mob/living/user, def_zone)
	if(!target)
		return

	if(cap_on && reagents.total_volume && istype(target))
		to_chat(user, span_warning("You must remove the cap before you can do that!"))
		return

	return ..()

/obj/item/reagent_containers/cup/glass/waterbottle/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/atom/target = interacting_with // Yes i am supremely lazy

	if(cap_on && (target.is_refillable() || target.is_drainable() || (reagents.total_volume)))
		to_chat(user, span_warning("You must remove the cap before you can do that."))
		return ITEM_INTERACT_BLOCKING

	else if(istype(target, /obj/item/reagent_containers/cup/glass/waterbottle))
		var/obj/item/reagent_containers/cup/glass/waterbottle/WB = target
		if(WB.cap_on)
			to_chat(user, span_warning("[WB] has a cap firmly twisted on."))
			return ITEM_INTERACT_BLOCKING

	return ..()

// heehoo bottle flipping
/obj/item/reagent_containers/cup/glass/waterbottle/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!QDELETED(src) && cap_on && reagents.total_volume)
		if(prob(flip_chance)) // landed upright
			src.visible_message(span_notice("[src] lands upright!"))
		else // landed on it's side
			animate(src, transform = matrix(prob(50)? 90 : -90, MATRIX_ROTATE), time = 3, loop = 0)

/obj/item/reagent_containers/cup/glass/waterbottle/pickup(mob/user)
	. = ..()
	animate(src, transform = null, time = 1, loop = 0)

/obj/item/reagent_containers/cup/glass/waterbottle/empty
	list_reagents = list()
	cap_on = FALSE

TYPEINFO_DEF(/obj/item/reagent_containers/cup/glass/waterbottle/large)
	default_materials = list(/datum/material/plastic=3000)

/obj/item/reagent_containers/cup/glass/waterbottle/large
	desc = "A fresh commercial-sized bottle of water."
	icon_state = "largebottle"
	list_reagents = list(/datum/reagent/water = 100)
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100)
	cap_icon_state = "bottle_cap"

/obj/item/reagent_containers/cup/glass/waterbottle/large/empty
	list_reagents = list()
	cap_on = FALSE

// Admin spawn
/obj/item/reagent_containers/cup/glass/waterbottle/relic
	name = "mysterious bottle"
	desc = "A bottle quite similar to a water bottle, but with some words scribbled on with a marker. It seems to be radiating some kind of energy."
	flip_chance = 100 // FLIPP

/obj/item/reagent_containers/cup/glass/waterbottle/relic/Initialize(mapload)
	var/reagent_id = get_random_reagent_id()
	var/datum/reagent/random_reagent = new reagent_id
	list_reagents = list(random_reagent.type = 50)
	. = ..()
	desc += span_notice("The writing reads '[random_reagent.name]'.")
	update_appearance()


/obj/item/reagent_containers/cup/glass/sillycup
	name = "paper cup"
	desc = "A paper water cup."
	icon_state = "water_cup_e"
	possible_transfer_amounts = list(10)
	volume = 10
	spillable = TRUE
	isGlass = FALSE

/obj/item/reagent_containers/cup/glass/sillycup/update_icon_state()
	icon_state = reagents.total_volume ? "water_cup" : "water_cup_e"
	return ..()

/obj/item/reagent_containers/cup/glass/sillycup/smallcarton
	name = "small carton"
	desc = "A small carton, intended for holding drinks."
	icon_state = "juicebox"
	volume = 15 //I figure if you have to craft these it should at least be slightly better than something you can get for free from a watercooler

/// Reagent container icon updates, especially this one, are complete jank. I will need to rework them after this is merged.
/obj/item/reagent_containers/cup/glass/sillycup/smallcarton/on_reagent_change(datum/reagents/holder, ...)
	. = ..()
	if(!length(reagents.reagent_list))
		drink_type = NONE /// Why are food types on the _container_? TODO: move these to the reagents
		return

	switch(reagents.get_master_reagent_id())
		if(/datum/reagent/consumable/orangejuice)
			drink_type = FRUIT | BREAKFAST
		if(/datum/reagent/consumable/milk)
			drink_type = DAIRY | BREAKFAST
		if(/datum/reagent/consumable/applejuice)
			drink_type = FRUIT
		if(/datum/reagent/consumable/grapejuice)
			drink_type = FRUIT
		if(/datum/reagent/consumable/pineapplejuice)
			drink_type = FRUIT | PINEAPPLE
		if(/datum/reagent/consumable/milk/chocolate_milk)
			drink_type = SUGAR
		if(/datum/reagent/consumable/ethanol/eggnog)
			drink_type = MEAT

/obj/item/reagent_containers/cup/glass/sillycup/smallcarton/update_name(updates)
	. = ..()
	if(!length(reagents.reagent_list))
		name = "small carton"
		return

	switch(reagents.get_master_reagent_id())
		if(/datum/reagent/consumable/orangejuice)
			name = "orange juice box"
		if(/datum/reagent/consumable/milk)
			name = "carton of milk"
		if(/datum/reagent/consumable/applejuice)
			name = "apple juice box"
		if(/datum/reagent/consumable/grapejuice)
			name = "grape juice box"
		if(/datum/reagent/consumable/pineapplejuice)
			name = "pineapple juice box"
		if(/datum/reagent/consumable/milk/chocolate_milk)
			name = "carton of chocolate milk"
		if(/datum/reagent/consumable/ethanol/eggnog)
			name = "carton of eggnog"

/obj/item/reagent_containers/cup/glass/sillycup/smallcarton/update_desc(updates)
	. = ..()
	if(!length(reagents.reagent_list))
		desc = "A small carton, intended for holding drinks."
		return

	switch(reagents.get_master_reagent_id())
		if(/datum/reagent/consumable/orangejuice)
			desc = "A great source of vitamins. Stay healthy!"
		if(/datum/reagent/consumable/milk)
			desc = "An excellent source of calcium for growing space explorers."
		if(/datum/reagent/consumable/applejuice)
			desc = "Sweet apple juice. Don't be late for school!"
		if(/datum/reagent/consumable/grapejuice)
			desc = "Tasty grape juice in a fun little container. Non-alcoholic!"
		if(/datum/reagent/consumable/pineapplejuice)
			desc = "Why would you even want this?"
		if(/datum/reagent/consumable/milk/chocolate_milk)
			desc = "Milk for cool kids!"
		if(/datum/reagent/consumable/ethanol/eggnog)
			desc = "For enjoying the most wonderful time of the year."


/obj/item/reagent_containers/cup/glass/sillycup/smallcarton/update_icon_state()
	. = ..()
	if(!length(reagents.reagent_list))
		icon_state = "juicebox"
		return

	switch(reagents.get_master_reagent_id()) // Thanks to update_name not existing we need to do this whole switch twice
		if(/datum/reagent/consumable/orangejuice)
			icon_state = "orangebox"
		if(/datum/reagent/consumable/milk)
			icon_state = "milkbox"
		if(/datum/reagent/consumable/applejuice)
			icon_state = "juicebox"
		if(/datum/reagent/consumable/grapejuice)
			icon_state = "grapebox"
		if(/datum/reagent/consumable/pineapplejuice)
			icon_state = "pineapplebox"
		if(/datum/reagent/consumable/milk/chocolate_milk)
			icon_state = "chocolatebox"
		if(/datum/reagent/consumable/ethanol/eggnog)
			icon_state = "nog2"
		else
			icon_state = "juicebox"

/obj/item/reagent_containers/cup/glass/sillycup/smallcarton/smash(atom/target, mob/thrower, ranged = FALSE)
	if(bartender_check(target) && ranged)
		return

	SplashReagents(target, ranged, override_spillable = TRUE)
	var/obj/item/broken_bottle/B = new (loc)
	B.mimic_broken(src, target)
	qdel(src)
	target.BumpedBy(B)

TYPEINFO_DEF(/obj/item/reagent_containers/cup/glass/colocup)
	default_materials = list(/datum/material/plastic = 1000)

/obj/item/reagent_containers/cup/glass/colocup
	name = "colo cup"
	desc = "A cheap, mass produced style of cup, typically used at parties. They never seem to come out red, for some reason..."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "colocup"
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	inhand_icon_state = "colocup"
	possible_transfer_amounts = list(5, 10, 15, 20)
	volume = 20
	amount_per_transfer_from_this = 5
	isGlass = FALSE
	/// Allows the lean sprite to display upon crafting
	var/random_sprite = TRUE

/obj/item/reagent_containers/cup/glass/colocup/Initialize(mapload)
	.=..()
	pixel_x = rand(-4,4)
	pixel_y = rand(-4,4)
	if (random_sprite)
		icon_state = "colocup[rand(0, 6)]"
		if (icon_state == "colocup6")
			desc = "A cheap, mass produced style of cup, typically used at parties. Woah, this one is in red! What the hell?"

//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places: In Chemistry-Reagents.dm (for the drink
// itself), in Chemistry-Recipes.dm (for the reaction that changes the components into the drink), and here (for the drinking glass
// icon states.

TYPEINFO_DEF(/obj/item/reagent_containers/cup/glass/shaker)
	default_materials = list(/datum/material/iron=1500)

/obj/item/reagent_containers/cup/glass/shaker
	name = "shaker"
	desc = "A metal shaker to mix drinks in."
	icon_state = "shaker"
	amount_per_transfer_from_this = 10
	volume = 100
	isGlass = FALSE

TYPEINFO_DEF(/obj/item/reagent_containers/cup/glass/flask)
	default_materials = list(/datum/material/iron=250)

/obj/item/reagent_containers/cup/glass/flask
	name = "flask"
	desc = "Every good spaceman knows it's a good idea to bring along a couple of pints of whiskey wherever they go."
	custom_price = PAYCHECK_ASSISTANT * 3.5
	icon_state = "flask"
	volume = 60
	isGlass = FALSE

TYPEINFO_DEF(/obj/item/reagent_containers/cup/glass/flask/gold)
	default_materials = list(/datum/material/gold=500)

/obj/item/reagent_containers/cup/glass/flask/gold
	name = "captain's flask"
	desc = "A gold flask belonging to the captain."
	icon_state = "flask_gold"

/obj/item/reagent_containers/cup/glass/flask/det
	name = "detective's flask"
	desc = "The detective's only true friend."
	icon_state = "detflask"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 30)
