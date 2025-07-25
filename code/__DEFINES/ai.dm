#define GET_AI_BEHAVIOR(behavior_type) SSai_behaviors.ai_behaviors[behavior_type]
#define GET_TARGETING_STRATEGY(targeting_type) SSai_behaviors.targeting_strategies[targeting_type]
#define HAS_AI_CONTROLLER_TYPE(thing, type) istype(thing?.ai_controller, type)

#ifdef DEBUG_AI
#define DEBUG_AI_LOG(controller, message) if(controller.debug_focus) { to_chat(world, span_debug("AI DBG: [message]")) }
#else
#define DEBUG_AI_LOG(...)
#endif

#define AI_STATUS_ON 1
#define AI_STATUS_OFF 2

///For JPS pathing, the maximum length of a path we'll try to generate. Should be modularized depending on what we're doing later on
#define AI_MAX_PATH_LENGTH 30 // 30 is possibly overkill since by default we lose interest after 14 tiles of distance, but this gives wiggle room for weaving around obstacles

///Cooldown on planning if planning failed last time

#define AI_FAILED_PLANNING_COOLDOWN 1.5 SECONDS

///Flags for ai_behavior new()
#define AI_CONTROLLER_INCOMPATIBLE (1<<0)

//Flags for behavior/perform()
#define BEHAVIOR_PERFORM_INSTANT (NONE)
#define BEHAVIOR_PERFORM_COOLDOWN (1<<0)
#define BEHAVIOR_PERFORM_SUCCESS (1<<1)
#define BEHAVIOR_PERFORM_FAILURE (1<<2)

///Does this task require movement from the AI before it can be performed?
#define AI_BEHAVIOR_REQUIRE_MOVEMENT (1<<0)
///Does this task let you perform the action while you move closer? (Things like moving and shooting)
#define AI_BEHAVIOR_MOVE_AND_PERFORM (1<<1)
///Does finishing this task not null the current movement target?
#define AI_BEHAVIOR_KEEP_MOVE_TARGET_ON_FINISH (1<<2)
///Does finishing this task make the AI stop moving towards the target?
#define AI_BEHAVIOR_KEEP_MOVING_TOWARDS_TARGET_ON_FINISH (1<<3)
///Does this behavior NOT block planning?
#define AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION (1<<4)
///Does this require the current_movement_target to be adjacent and in reach?
#define AI_BEHAVIOR_REQUIRE_REACH (1<<5)


///AI flags
#define STOP_MOVING_WHEN_PULLED (1<<0)

//Base Subtree defines

///This subtree should cancel any further planning, (Including from other subtrees)
#define SUBTREE_RETURN_FINISH_PLANNING 1

//Generic subtree defines

/// probability that the pawn should try resisting out of restraints
#define RESIST_SUBTREE_PROB 50
///macro for whether it's appropriate to resist right now, used by resist subtree
#define SHOULD_RESIST(source) (source.on_fire || source.buckled || HAS_TRAIT(source, TRAIT_ARMS_RESTRAINED) || HAS_TRAIT(source, TRAIT_AGGRESSIVE_GRAB))
///macro for whether the pawn can act, used generally to prevent some horrifying ai disasters
#define IS_DEAD_OR_INCAP(source) (source.incapacitated() || source.stat)

//Generic BB keys
#define BB_CURRENT_MIN_MOVE_DISTANCE "min_move_distance"
///time until we should next eat, set by the generic hunger subtree
#define BB_NEXT_HUNGRY "BB_NEXT_HUNGRY"
///what we're going to eat next
#define BB_FOOD_TARGET "bb_food_target"
///Path we should use next time we use the JPS movement datum
#define BB_PATH_TO_USE "BB_path_to_use"
///Max path length we should use next time we use the JPS movement datum
#define BB_PATH_MAX_LENGTH "BB_path_max_length"
///Diagonal handling we should use next time we use the JPS movement datum
#define BB_PATH_DIAGONAL_HANDLING "BB_path_diagonal_handling"
/// Typecache of refs to mobs this mob is friends with, will follow their instructions and won't attack them
#define BB_FRIENDS_LIST "BB_FRIENDS_LIST"
/// World.time of the last movement + the pawn's movement delay
#define BB_NEXT_MOVE_TIME "BB_NEXT_MOVE_TIME"

//for songs
///song instrument blackboard, set by instrument subtrees
#define BB_SONG_INSTRUMENT "BB_SONG_INSTRUMENT"
///song lines blackboard, set by default on controllers
#define BB_SONG_LINES "song_lines"

// Monkey AI controller blackboard keys

#define BB_MONKEY_AGGRESSIVE "BB_monkey_aggressive"
#define BB_MONKEY_GUN_NEURONS_ACTIVATED "BB_monkey_gun_aware"
#define BB_MONKEY_GUN_WORKED "BB_monkey_gun_worked"
#define BB_MONKEY_BEST_FORCE_FOUND "BB_monkey_bestforcefound"
#define BB_MONKEY_ENEMIES "BB_monkey_enemies"
#define BB_MONKEY_BLACKLISTITEMS "BB_monkey_blacklistitems"
#define BB_MONKEY_PICKUPTARGET "BB_monkey_pickuptarget"
#define BB_MONKEY_PICKPOCKETING "BB_monkey_pickpocketing"
#define BB_MONKEY_CURRENT_ATTACK_TARGET "BB_monkey_current_attack_target"
#define BB_MONKEY_CURRENT_PRESS_TARGET "BB_monkey_current_press_target"
#define BB_MONKEY_CURRENT_GIVE_TARGET "BB_monkey_current_give_target"
#define BB_MONKEY_TARGET_DISPOSAL "BB_monkey_target_disposal"
#define BB_MONKEY_DISPOSING "BB_monkey_disposing"
#define BB_MONKEY_RECRUIT_COOLDOWN "BB_monkey_recruit_cooldown"

///Haunted item controller defines

///Chance for haunted item to haunt someone
#define HAUNTED_ITEM_ATTACK_HAUNT_CHANCE 10
///Chance for haunted item to try to get itself let go.
#define HAUNTED_ITEM_ESCAPE_GRASP_CHANCE 20
///Amount of aggro you get when picking up a haunted item
#define HAUNTED_ITEM_AGGRO_ADDITION 2

///Blackboard keys for haunted items
#define BB_TO_HAUNT_LIST "BB_to_haunt_list"
///Actual mob the item is haunting at the moment
#define BB_HAUNT_TARGET "BB_haunt_target"
///Amount of successful hits in a row this item has had
#define BB_HAUNTED_THROW_ATTEMPT_COUNT "BB_haunted_throw_attempt_count"
///If true, tolerates the equipper holding/equipping the hauntium
#define BB_LIKES_EQUIPPER "BB_likes_equipper"

///Cursed item controller defines

//defines
///how far a cursed item will still try to chase a target
#define CURSED_VIEW_RANGE 7
//blackboards

///Actual mob the item is haunting at the moment
#define BB_CURSE_TARGET "BB_haunt_target"
///Where the item wants to land on
#define BB_TARGET_SLOT "BB_target_slot"
///Amount of successful hits in a row this item has had
#define BB_CURSED_THROW_ATTEMPT_COUNT "BB_cursed_throw_attempt_count"

///Mob the MOD is trying to attach to
#define BB_MOD_TARGET "BB_mod_target"
///The implant the AI was created from
#define BB_MOD_IMPLANT "BB_mod_implant"
///Range for a MOD AI controller.
#define MOD_AI_RANGE 200

///Vending machine AI controller blackboard keys
#define BB_VENDING_CURRENT_TARGET "BB_vending_current_target"
#define BB_VENDING_TILT_COOLDOWN "BB_vending_tilt_cooldown"
#define BB_VENDING_UNTILT_COOLDOWN "BB_vending_untilt_cooldown"
#define BB_VENDING_BUSY_TILTING "BB_vending_busy_tilting"
#define BB_VENDING_LAST_HIT_SUCCESFUL "BB_vending_last_hit_succesful"

///Robot customer AI controller blackboard keys
#define BB_CUSTOMER_CURRENT_ORDER "BB_customer_current_order"
#define BB_CUSTOMER_MY_SEAT "BB_customer_my_seat"
#define BB_CUSTOMER_PATIENCE "BB_customer_patience"
#define BB_CUSTOMER_CUSTOMERINFO "BB_customer_customerinfo"
#define BB_CUSTOMER_EATING "BB_customer_eating"
#define BB_CUSTOMER_ATTENDING_VENUE "BB_customer_attending_avenue"
#define BB_CUSTOMER_LEAVING "BB_customer_leaving"
#define BB_CUSTOMER_CURRENT_TARGET "BB_customer_current_target"
/// Robot customer has said their can't find seat line at least once. Used to rate limit how often they'll complain after the first time.
#define BB_CUSTOMER_SAID_CANT_FIND_SEAT_LINE "BB_customer_said_cant_find_seat_line"


///Hostile AI controller blackboard keys
#define BB_TARGETING_STRATEGY "BB_TARGETING_STRATEGY"
#define BB_TARGET_MINIMUM_STAT "BB_TARGET_MINIMUM_STAT"
#define BB_HOSTILE_ORDER_MODE "BB_HOSTILE_ORDER_MODE"
#define BB_HOSTILE_FRIEND "BB_HOSTILE_FRIEND"
#define BB_HOSTILE_ATTACK_WORD "BB_HOSTILE_ATTACK_WORD"
#define BB_FOLLOW_TARGET "BB_FOLLOW_TARGET"
#define BB_ATTACK_TARGET "BB_ATTACK_TARGET"
#define BB_VISION_RANGE "BB_VISION_RANGE"

///should we skip the faction check for the targeting strategy?
#define BB_ALWAYS_IGNORE_FACTION "BB_always_ignore_factions"
///are we in some kind of temporary state of ignoring factions when targeting? can result in volatile results if multiple behaviours touch this
#define BB_TEMPORARILY_IGNORE_FACTION "BB_temporarily_ignore_factions"

/// Basically, what is our vision/hearing range.
#define BB_HOSTILE_VISION_RANGE 10
/// After either being given a verbal order or a pointing order, ignore further of each for this duration
#define AI_HOSTILE_COMMAND_COOLDOWN 2 SECONDS

// hostile command modes (what pointing at something/someone does depending on the last order the carp heard)
/// Don't do anything (will still react to stuff around them though)
#define HOSTILE_COMMAND_NONE 0
/// Will attack a target.
#define HOSTILE_COMMAND_ATTACK 1
/// Will follow a target.
#define HOSTILE_COMMAND_FOLLOW 2

///Dog AI controller blackboard keys

#define BB_SIMPLE_CARRY_ITEM "BB_SIMPLE_CARRY_ITEM"
#define BB_FETCH_TARGET "BB_FETCH_TARGET"
#define BB_FETCH_IGNORE_LIST "BB_FETCH_IGNORE_LIST"
#define BB_FETCH_DELIVER_TO "BB_FETCH_DELIVER_TO"
#define BB_DOG_ORDER_MODE "BB_DOG_ORDER_MODE"
#define BB_DOG_PLAYING_DEAD "BB_DOG_PLAYING_DEAD"
#define BB_DOG_HARASS_TARGET "BB_DOG_HARASS_TARGET"
#define BB_DOG_HARASS_FRUSTRATION "BB_DOG_HARASS_FRUSTRATION"

/// Basically, what is our vision/hearing range for picking up on things to fetch/
#define AI_DOG_VISION_RANGE	10
/// What are the odds someone petting us will become our friend?
#define AI_DOG_PET_FRIEND_PROB 15
/// After this long without having fetched something, we clear our ignore list
#define AI_FETCH_IGNORE_DURATION 30 SECONDS
/// After being ordered to heel, we spend this long chilling out
#define AI_DOG_HEEL_DURATION 20 SECONDS
/// After either being given a verbal order or a pointing order, ignore further of each for this duration
#define AI_DOG_COMMAND_COOLDOWN 2 SECONDS
/// If the dog is set to harass someone but doesn't bite them for this long, give up
#define AI_DOG_HARASS_FRUSTRATE_TIME 50 SECONDS

// dog command modes (what pointing at something/someone does depending on the last order the dog heard)
/// Don't do anything (will still react to stuff around them though)
#define DOG_COMMAND_NONE 0
/// Will try to pick up and bring back whatever you point to
#define DOG_COMMAND_FETCH 1
/// Will get within a few tiles of whatever you point at and continually growl/bark. If the target is a living mob who gets too close, the dog will attack them with bites
#define DOG_COMMAND_ATTACK 2

//enumerators for parsing command speech
#define COMMAND_HEEL "Heel"
#define COMMAND_FETCH "Fetch"
#define COMMAND_FOLLOW "Follow"
#define COMMAND_STOP "Stop"
#define COMMAND_ATTACK "Attack"
#define COMMAND_DIE "Play Dead"

///bane ai
#define BB_BANE_BATMAN "BB_bane_batman"
//yep thats it


//Hunting defines
#define SUCCESFUL_HUNT_COOLDOWN 5 SECONDS

///Hunting BB keys
#define BB_CURRENT_HUNTING_TARGET "BB_current_hunting_target"
#define BB_HUNTING_COOLDOWN "BB_HUNTING_COOLDOWN"

///Basic Mob Keys

///Tipped blackboards
///Bool that means a basic mob will start reacting to being tipped in it's planning
#define BB_BASIC_MOB_TIP_REACTING "BB_basic_tip_reacting"
///the motherfucker who tipped us
#define BB_BASIC_MOB_TIPPER "BB_basic_tip_tipper"

///Targetting subtrees
#define BB_BASIC_MOB_CURRENT_TARGET "BB_basic_current_target"
#define BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION "BB_basic_current_target_hiding_location"

/// The list of behaviors for the planners to select from. THIS IS ACTUALLY A SUBKEY!! See _behavior_planner.dm
#define BB_PLANNER_BEHAVIORS "BB_planner_behaviors"

#define BB_FLOCK_STARING_ACTIVE "BB_flock_staring"
#define BB_FLOCK_STARE_TARGET "BB_flock_stare_target"
#define BB_FLOCK_WANDERING "BB_flock_wandering"
#define BB_FLOCK_STARE_CD "BB_flock_stare_cooldown"
#define BB_FLOCK_CONVERT_TARGET "BB_flock_convert_target"
#define BB_FLOCK_WANDER_FRUSTRATION "BB_flock_wander_frustration"
#define BB_FLOCK_HEAL_TARGET "BB_flock_heal_target"
#define BB_FLOCK_HEAL_FRUSTRATION "BB_flock_heal_frustation"
#define BB_FLOCK_OVERMIND_CONTROL "BB_flock_overmind_control"
