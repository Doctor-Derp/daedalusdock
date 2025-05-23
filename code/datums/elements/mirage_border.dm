/**
 * Creates a mirage effect allowing you to see around the world border, by adding the opposite side to its vis_contents.
 */
/datum/element/mirage_border

/datum/element/mirage_border/Attach(datum/target, turf/target_turf, direction, range=world.view)
	. = ..()
	if(!isturf(target))
		return ELEMENT_INCOMPATIBLE
	#ifdef TESTING
	// This is a highly used proc, and these error states never occur, so limit it to testing.
	// If something goes wrong it will runtime anyway.
	if(!target_turf || !istype(target_turf) || !direction)
		stack_trace("[type] improperly attached with the following args: target=\[[target_turf]\], direction=\[[direction]\], range=\[[range]\]")
		return ELEMENT_INCOMPATIBLE
	#endif

	var/atom/movable/mirage_holder/holder = new(target)

	var/x = target_turf.x
	var/y = target_turf.y
	var/z = clamp(target_turf.z, 1, world.maxz)
	var/turf/southwest = locate(clamp(x - (direction & WEST ? range : 0), 1, world.maxx), clamp(y - (direction & SOUTH ? range : 0), 1, world.maxy), z)
	var/turf/northeast = locate(clamp(x + (direction & EAST ? range : 0), 1, world.maxx), clamp(y + (direction & NORTH ? range : 0), 1, world.maxy), z)
	holder.add_viscontents(block(southwest, northeast))
	if(direction & SOUTH)
		holder.pixel_y -= world.icon_size * range
	if(direction & WEST)
		holder.pixel_x -= world.icon_size * range

/datum/element/mirage_border/Detach(atom/movable/target)
	. = ..()
	var/atom/movable/mirage_holder/held = locate() in target.contents
	if(held)
		qdel(held)

INITIALIZE_IMMEDIATE(/atom/movable/mirage_holder)
// Using /atom/movable because this is a heavily used path
/atom/movable/mirage_holder
	name = "Mirage holder"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/mirage_holder/Initialize(mapload)
	SHOULD_CALL_PARENT(FALSE)
	if(initialized)
		stack_trace("Warning: [src]([type]) initialized multiple times!")
	initialized = TRUE
	return INITIALIZE_HINT_NORMAL

/atom/movable/mirage_holder/Destroy(force)
	SHOULD_CALL_PARENT(FALSE)
	loc = null
	return QDEL_HINT_QUEUE
