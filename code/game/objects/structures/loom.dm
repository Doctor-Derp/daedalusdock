#define FABRIC_PER_SHEET 4


///This is a loom. It's usually made out of wood and used to weave fabric like durathread or cotton into their respective cloth types.
/obj/structure/loom
	name = "loom"
	desc = "A simple device used to weave cloth and other thread-based fabrics together into usable material."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "loom"
	density = TRUE
	anchored = TRUE

/obj/structure/loom/Initialize(mapload)
	. = ..()

	var/static/list/hovering_item_typechecks = list(
		/obj/item/stack/sheet/cotton = list(
			SCREENTIP_CONTEXT_LMB = "Weave",
		),
	)

	AddElement(/datum/element/contextual_screentip_item_typechecks, hovering_item_typechecks)

/obj/structure/loom/attackby(obj/item/I, mob/user)
	if(weave(I, user))
		return
	return ..()

/obj/structure/loom/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool, time = 0.5 SECONDS)
	return ITEM_INTERACT_SUCCESS

///Handles the weaving.
/obj/structure/loom/proc/weave(obj/item/stack/sheet/cotton/W, mob/user)
	if(!istype(W))
		return FALSE
	if(!anchored)
		user.show_message(span_notice("The loom needs to be wrenched down."), MSG_VISUAL)
		return FALSE
	if(W.amount < FABRIC_PER_SHEET)
		user.show_message(span_notice("You need at least [FABRIC_PER_SHEET] units of fabric before using this."), MSG_VISUAL)
		return FALSE
	user.show_message(span_notice("You start weaving \the [W.name] through the loom.."), MSG_VISUAL)
	while(W.use_tool(src, user, W.pull_effort) && W.use(FABRIC_PER_SHEET))
		new W.loom_result(drop_location())
		user.show_message(span_notice("You weave \the [W.name] into a workable fabric."), MSG_VISUAL)
	return TRUE

#undef FABRIC_PER_SHEET
