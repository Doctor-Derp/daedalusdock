//Command

/obj/item/circuitboard/machine/bsa/back
	name = "Bluespace Artillery Generator (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/bsa/back //No freebies!
	req_components = list(
		/obj/item/stock_parts/capacitor/quadratic = 5,
		/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/machine/bsa/front
	name = "Bluespace Artillery Bore (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/bsa/front
	req_components = list(
		/obj/item/stock_parts/manipulator/femto = 5,
		/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/machine/bsa/middle
	name = "Bluespace Artillery Fusor (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/bsa/middle
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 20,
		/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/machine/dna_vault
	name = "DNA Vault (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/dna_vault //No freebies!
	req_components = list(
		/obj/item/stock_parts/capacitor/super = 5,
		/obj/item/stock_parts/manipulator/pico = 5,
		/obj/item/stack/cable_coil = 2)

//Engineering

/obj/item/circuitboard/machine/announcement_system
	name = "Announcement System (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/announcement_system
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/autolathe
	name = "Autolathe (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/autolathe
	req_components = list(
		/obj/item/stock_parts/matter_bin = 3,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/disk/data = 1
	)
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/autolathe
	)

/obj/item/circuitboard/machine/grounding_rod
	name = "Grounding Rod (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/energy_accumulator/grounding_rod
	req_components = list(/obj/item/stock_parts/capacitor = 1)
	needs_anchored = FALSE


/obj/item/circuitboard/machine/telecomms/broadcaster
	name = "Subspace Broadcaster (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/broadcaster
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stock_parts/subspace/filter = 1,
		/obj/item/stock_parts/subspace/crystal = 1,
		/obj/item/stock_parts/micro_laser = 2)

/obj/item/circuitboard/machine/telecomms/bus
	name = "Bus Mainframe (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/bus
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stock_parts/subspace/filter = 1)

/obj/item/circuitboard/machine/telecomms/hub
	name = "Hub Mainframe (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/hub
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stock_parts/subspace/filter = 2)

/obj/item/circuitboard/machine/telecomms/message_server
	name = "Messaging Server (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/message_server
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stock_parts/subspace/filter = 3)

/obj/item/circuitboard/machine/telecomms/processor
	name = "Processor Unit (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/processor
	req_components = list(
		/obj/item/stock_parts/manipulator = 3,
		/obj/item/stock_parts/subspace/filter = 1,
		/obj/item/stock_parts/subspace/treatment = 2,
		/obj/item/stock_parts/subspace/analyzer = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stock_parts/subspace/amplifier = 1)

/obj/item/circuitboard/machine/telecomms/receiver
	name = "Subspace Receiver (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/receiver
	req_components = list(
		/obj/item/stock_parts/subspace/ansible = 1,
		/obj/item/stock_parts/subspace/filter = 1,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/micro_laser = 1)

/obj/item/circuitboard/machine/telecomms/relay
	name = "Relay Mainframe (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/relay
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stock_parts/subspace/filter = 2)

/obj/item/circuitboard/machine/telecomms/server
	name = "Telecommunication Server (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/server
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stock_parts/subspace/filter = 1)

/obj/item/circuitboard/machine/tesla_coil
	name = "Tesla Controller (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	desc = "Does not let you shoot lightning from your hands."
	build_path = /obj/machinery/power/energy_accumulator/tesla_coil
	req_components = list(/obj/item/stock_parts/capacitor = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/cell_charger
	name = "Cell Charger (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/cell_charger
	req_components = list(/obj/item/stock_parts/capacitor = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/emitter
	name = "Emitter (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/emitter
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/manipulator = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/ntnet_relay
	name = "NTNet Relay (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/ntnet_relay
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/stock_parts/subspace/filter = 1)

/obj/item/circuitboard/machine/pacman
	name = "PACMAN-type Generator (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/port_gen/pacman
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stock_parts/capacitor = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/pacman/super
	name = "SUPERPACMAN-type Generator (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/port_gen/pacman/super

/obj/item/circuitboard/machine/fabricator/department/engineering
	name = "Departmental Fabricator - Engineering (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/rnd/production/fabricator/department/engineering
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/engineering
	)

/obj/item/circuitboard/machine/fabricator/department/civvie
	name = "Departmental Fabricator - Civilian (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/rnd/production/fabricator/department/civvie
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/civ
	)

/obj/item/circuitboard/machine/rtg
	name = "RTG (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/rtg
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stack/sheet/mineral/uranium = 10) // We have no Pu-238, and this is the closest thing to it.

/obj/item/circuitboard/machine/rtg/advanced
	name = "Advanced RTG (Machine Board)"
	build_path = /obj/machinery/power/rtg/advanced
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stack/sheet/mineral/uranium = 10,
		/obj/item/stack/sheet/mineral/plasma = 5)

/obj/item/circuitboard/machine/scanner_gate
	name = "Scanner Gate (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/scanner_gate
	req_components = list(
		/obj/item/stock_parts/scanning_module = 3)

/obj/item/circuitboard/machine/smes
	name = "SMES (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/smes
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/cell = 5,
		/obj/item/stock_parts/capacitor = 1)
	def_components = list(
		/obj/item/stock_parts/cell = /obj/item/stock_parts/cell/high/empty,
		/obj/item/stock_parts/capacitor = /obj/item/stock_parts/capacitor/adv
	)

/obj/item/circuitboard/machine/thermomachine
	name = "Thermomachine (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/atmospherics/components/unary/thermomachine/freezer
	var/pipe_layer = PIPING_LAYER_DEFAULT
	req_components = list(
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/thermomachine/multitool_act(mob/living/user, obj/item/multitool/multitool)
	. = ..()
	pipe_layer = (pipe_layer >= PIPING_LAYER_MAX) ? PIPING_LAYER_MIN : (pipe_layer + 1)
	to_chat(user, span_notice("You change the circuitboard to layer [pipe_layer]."))

/obj/item/circuitboard/machine/thermomachine/examine()
	. = ..()
	. += span_notice("It is set to layer [pipe_layer].")

//FIXME: HYPERGARBAGE DONUT CREATION CODE
// /obj/item/circuitboard/machine/HFR_fuel_input
// 	name = "HFR Fuel Input (Machine Board)"
// 	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
// 	build_path = /obj/machinery/atmospherics/components/unary/hypertorus/fuel_input
// 	req_components = list(
// 		/obj/item/stack/sheet/plasteel = 5)

// /obj/item/circuitboard/machine/HFR_waste_output
// 	name = "HFR Waste Output (Machine Board)"
// 	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
// 	build_path = /obj/machinery/atmospherics/components/unary/hypertorus/waste_output
// 	req_components = list(
// 		/obj/item/stack/sheet/plasteel = 5)

// /obj/item/circuitboard/machine/HFR_moderator_input
// 	name = "HFR Moderator Input (Machine Board)"
// 	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
// 	build_path = /obj/machinery/atmospherics/components/unary/hypertorus/moderator_input
// 	req_components = list(
// 		/obj/item/stack/sheet/plasteel = 5)

// /obj/item/circuitboard/machine/HFR_core
// 	name = "HFR core (Machine Board)"
// 	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
// 	build_path = /obj/machinery/atmospherics/components/unary/hypertorus/core
// 	req_components = list(
// 		/obj/item/stack/cable_coil = 10,
// 		/obj/item/stack/sheet/glass = 10,
// 		/obj/item/stack/sheet/plasteel = 10)

// /obj/item/circuitboard/machine/HFR_corner
// 	name = "HFR Corner (Machine Board)"
// 	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
// 	build_path = /obj/machinery/hypertorus/corner
// 	req_components = list(
// 		/obj/item/stack/sheet/plasteel = 5)

// /obj/item/circuitboard/machine/HFR_interface
// 	name = "HFR Interface (Machine Board)"
// 	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
// 	build_path = /obj/machinery/hypertorus/interface
// 	req_components = list(
// 		/obj/item/stack/cable_coil = 10,
// 		/obj/item/stack/sheet/glass = 10,
// 		/obj/item/stack/sheet/plasteel = 5)

// /obj/item/circuitboard/machine/crystallizer
// 	name = "Crystallizer (Machine Board)"
// 	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
// 	build_path = /obj/machinery/atmospherics/components/binary/crystallizer
// 	req_components = list(
// 		/obj/item/stack/cable_coil = 10,
// 		/obj/item/stack/sheet/glass = 10,
// 		/obj/item/stack/sheet/plasteel = 5)

/obj/item/circuitboard/machine/bluespace_sender
	name = "Bluespace Sender (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	//build_path = /obj/machinery/atmospherics/components/unary/bluespace_sender
	req_components = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/stack/sheet/glass = 10,
		/obj/item/stack/sheet/plasteel = 5)

//Generic

/obj/item/circuitboard/machine/circuit_imprinter
	name = "Circuit Imprinter (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/rnd/production/circuit_imprinter
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/reagent_containers/cup/beaker = 2,
		/obj/item/disk/data = 1
	)
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/imprinter
	)

/obj/item/circuitboard/machine/circuit_imprinter/offstation
	name = "Ancient Circuit Imprinter (Machine Board)"
	build_path = /obj/machinery/rnd/production/circuit_imprinter/offstation
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/imprinter/offstation
	)

/obj/item/circuitboard/machine/circuit_imprinter/robotics
	name = "Circuit Imprinter (Machine Board)"
	build_path = /obj/machinery/rnd/production/circuit_imprinter/offstation
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/imprinter/robotics
	)

/obj/item/circuitboard/machine/holopad
	name = "AI Holopad (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/holopad
	req_components = list(/obj/item/stock_parts/capacitor = 1)
	needs_anchored = FALSE //wew lad
	var/secure = FALSE

/obj/item/circuitboard/machine/holopad/multitool_act(mob/living/user, obj/item/tool)
	if(secure)
		build_path = /obj/machinery/holopad
		secure = FALSE
	else
		build_path = /obj/machinery/holopad/secure
		secure = TRUE
	to_chat(user, span_notice("You [secure? "en" : "dis"]able the security on [src]"))
	return TRUE

/obj/item/circuitboard/machine/holopad/examine(mob/user)
	. = ..()
	. += "There is a connection port on this board that could be <b>pulsed</b>"
	if(secure)
		. += "There is a red light flashing next to the word \"secure\""

/obj/item/circuitboard/machine/launchpad
	name = "Bluespace Launchpad (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/launchpad
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stock_parts/manipulator = 1)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)

/obj/item/circuitboard/machine/fabricator
	name = "Fabricator (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/rnd/production/fabricator
	req_components = list(
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/reagent_containers/cup/beaker = 2,
		/obj/item/disk/data = 1
	)
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/omni
	)

/obj/item/circuitboard/machine/fabricator/omni
	name = "Omni-Fabricator (Machine Board)"
	build_path = /obj/machinery/rnd/production/fabricator/omni
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/omni
	)
/obj/item/circuitboard/machine/fabricator/offstation
	name = "Ancient Fabricator (Machine Board)"
	build_path = /obj/machinery/rnd/production/fabricator/offstation
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/offstation
	)
/obj/item/circuitboard/machine/fabricator/department
	name = "Departmental Fabricator (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/rnd/production/fabricator/department

/obj/item/circuitboard/machine/reagentgrinder
	name = "All-In-One Grinder (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/reagentgrinder/constructed
	req_components = list(
		/obj/item/stock_parts/manipulator = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/smartfridge
	name = "Smartfridge (Machine Board)"
	build_path = /obj/machinery/smartfridge
	req_components = list(/obj/item/stock_parts/matter_bin = 1)
	var/static/list/fridges_name_paths = list(/obj/machinery/smartfridge = "plant produce",
		/obj/machinery/smartfridge/food = "food",
		/obj/machinery/smartfridge/drinks = "drinks",
		/obj/machinery/smartfridge/extract = "slimes",
		/obj/machinery/smartfridge/organ = "organs",
		/obj/machinery/smartfridge/chemistry = "chems",
		/obj/machinery/smartfridge/chemistry/virology = "viruses",
		/obj/machinery/smartfridge/disks = "disks")
	needs_anchored = FALSE
	var/is_special_type = FALSE

/obj/item/circuitboard/machine/smartfridge/apply_default_parts(obj/machinery/smartfridge/smartfridge)
	build_path = smartfridge.base_build_path
	if(!fridges_name_paths.Find(build_path, fridges_name_paths))
		name = "[initial(smartfridge.name)] (Machine Board)" //if it's a unique type, give it a unique name.
		is_special_type = TRUE
	return ..()

/obj/item/circuitboard/machine/smartfridge/screwdriver_act(mob/living/user, obj/item/tool)
	if (is_special_type)
		return FALSE
	var/position = fridges_name_paths.Find(build_path, fridges_name_paths)
	position = (position == length(fridges_name_paths)) ? 1 : (position + 1)
	build_path = fridges_name_paths[position]
	to_chat(user, span_notice("You set the board to [fridges_name_paths[build_path]]."))
	return TRUE

/obj/item/circuitboard/machine/smartfridge/examine(mob/user)
	. = ..()
	if(is_special_type)
		return
	. += span_info("[src] is set to [fridges_name_paths[build_path]]. You can use a screwdriver to reconfigure it.")


/obj/item/circuitboard/machine/space_heater
	name = "Space Heater (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/space_heater/constructed
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stack/cable_coil = 3)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/electrolyzer
	name = "Electrolyzer (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	//build_path = /obj/machinery/electrolyzer
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/capacitor = 2,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/sheet/glass = 1)

	needs_anchored = FALSE

/obj/item/circuitboard/machine/vendor
	name = "Custom Vendor (Machine Board)"
	desc = "You can turn the \"brand selection\" dial using a screwdriver."
	custom_premium_price = PAYCHECK_ASSISTANT * 1.5
	build_path = /obj/machinery/vending/custom
	req_components = list(/obj/item/vending_refill/custom = 1)

	var/static/list/vending_names_paths = list(
		/obj/machinery/vending/boozeomat = "Booze-O-Mat",
		/obj/machinery/vending/coffee = "Solar's Best Hot Drinks",
		/obj/machinery/vending/snack = "Getmore Chocolate Corp",
		/obj/machinery/vending/cola = "Robust Softdrinks",
		/obj/machinery/vending/cigarette = "ShadyCigs Deluxe",
		/obj/machinery/vending/games = "\improper Good Clean Fun",
		/obj/machinery/vending/autodrobe = "AutoDrobe",
		/obj/machinery/vending/wardrobe/sec_wardrobe = "SecDrobe",
		/obj/machinery/vending/wardrobe/det_wardrobe = "DetDrobe",
		/obj/machinery/vending/wardrobe/medi_wardrobe = "MediDrobe",
		/obj/machinery/vending/wardrobe/engi_wardrobe = "EngiDrobe",
		/obj/machinery/vending/wardrobe/atmos_wardrobe = "AtmosDrobe",
		/obj/machinery/vending/wardrobe/cargo_wardrobe = "CargoDrobe",
		/obj/machinery/vending/wardrobe/robo_wardrobe = "RoboDrobe",
		/obj/machinery/vending/wardrobe/science_wardrobe = "SciDrobe",
		/obj/machinery/vending/wardrobe/hydro_wardrobe = "HyDrobe",
		/obj/machinery/vending/wardrobe/curator_wardrobe = "CuraDrobe",
		/obj/machinery/vending/wardrobe/bar_wardrobe = "BarDrobe",
		/obj/machinery/vending/wardrobe/chef_wardrobe = "ChefDrobe",
		/obj/machinery/vending/wardrobe/jani_wardrobe = "JaniDrobe",
		/obj/machinery/vending/wardrobe/law_wardrobe = "LawDrobe",
		/obj/machinery/vending/wardrobe/chap_wardrobe = "ChapDrobe",
		/obj/machinery/vending/wardrobe/chem_wardrobe = "ChemDrobe",
		/obj/machinery/vending/wardrobe/gene_wardrobe = "GeneDrobe",
		/obj/machinery/vending/wardrobe/viro_wardrobe = "ViroDrobe",
		/obj/machinery/vending/clothing = "ClothesMate",
		/obj/machinery/vending/medical = "NanoMed Plus",
		/obj/machinery/vending/drugs = "NanoDrug Plus",
		/obj/machinery/vending/wallmed = "NanoMed",
		/obj/machinery/vending/assist = "Part-Mart",
		/obj/machinery/vending/engivend = "Engi-Vend",
		/obj/machinery/vending/hydronutrients = "NutriMax",
		/obj/machinery/vending/hydroseeds = "MegaSeed Servitor",
		/obj/machinery/vending/sustenance = "Sustenance Vendor",
		/obj/machinery/vending/dinnerware = "Plasteel Chef's Dinnerware Vendor",
		/obj/machinery/vending/cart = "PTech",
		/obj/machinery/vending/robotics = "Robotech Deluxe",
		/obj/machinery/vending/engineering = "Robco Tool Maker",
		/obj/machinery/vending/sovietsoda = "BODA",
		/obj/machinery/vending/security = "SecTech",
		/obj/machinery/vending/modularpc = "Deluxe Silicate Selections",
		/obj/machinery/vending/tool = "YouTool",
		/obj/machinery/vending/custom = "Custom Vendor")

/obj/item/circuitboard/machine/vendor/screwdriver_act(mob/living/user, obj/item/tool)
	var/static/list/display_vending_names_paths
	if(!display_vending_names_paths)
		display_vending_names_paths = list()
		for(var/path in vending_names_paths)
			display_vending_names_paths[vending_names_paths[path]] = path
	var/choice = tgui_input_list(user, "Choose a new brand", "Select an Item", sort_list(display_vending_names_paths))
	if(isnull(choice))
		return
	if(isnull(display_vending_names_paths[choice]))
		return
	set_type(display_vending_names_paths[choice])
	return TRUE

/obj/item/circuitboard/machine/vendor/proc/set_type(obj/machinery/vending/typepath)
	build_path = typepath
	name = "[vending_names_paths[build_path]] Vendor (Machine Board)"
	req_components = list(initial(typepath.refill_canister) = 1)

/obj/item/circuitboard/machine/vendor/apply_default_parts(obj/machinery/machine)
	for(var/typepath in vending_names_paths)
		if(istype(machine, typepath))
			set_type(typepath)
			break
	return ..()

/obj/item/circuitboard/machine/vending/donksofttoyvendor
	name = "Donksoft Toy Vendor (Machine Board)"
	build_path = /obj/machinery/vending/donksofttoyvendor
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/vending_refill/donksoft = 1)

/obj/item/circuitboard/machine/vending/syndicatedonksofttoyvendor
	name = "Syndicate Donksoft Toy Vendor (Machine Board)"
	build_path = /obj/machinery/vending/toyliberationstation
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/vending_refill/donksoft = 1)

//Medical

/obj/item/circuitboard/machine/chem_dispenser
	name = "Chem Dispenser (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/chem_dispenser
	req_components = list(
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/sheet/glass = 1)
	def_components = list(/obj/item/stock_parts/cell = /obj/item/stock_parts/cell/high)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/chem_dispenser/mini
	name = "Mini Chem Dispenser (Machine Board)"
	build_path = /obj/machinery/chem_dispenser/mini
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/chem_dispenser/big
	name = "Big Chem Dispenser (Machine Board)"
	build_path = /obj/machinery/chem_dispenser/big
	req_components = list(
		/obj/item/stock_parts/matter_bin = 3,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/sheet/glass = 3)

/obj/item/circuitboard/machine/chem_dispenser/abductor
	name = "Reagent Synthesizer (Abductor Machine Board)"
	icon_state = "abductor_mod"
	build_path = /obj/machinery/chem_dispenser/abductor
	req_components = list(
		/obj/item/stock_parts/matter_bin/bluespace = 2,
		/obj/item/stock_parts/capacitor/quadratic = 2,
		/obj/item/stock_parts/manipulator/femto = 2,
		/obj/item/stack/sheet/glass = 1,
	)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/chem_heater
	name = "Chemical Heater (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/chem_heater
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/chem_master
	name = "ChemMaster 3000 (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/chem_master
	desc = "You can turn the \"mode selection\" dial using a screwdriver."
	req_components = list(
		/obj/item/reagent_containers/cup/beaker = 2,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/sheet/glass = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/chem_master/screwdriver_act(mob/living/user, obj/item/tool)
	var/new_name = "ChemMaster"
	var/new_path = /obj/machinery/chem_master

	if(build_path == /obj/machinery/chem_master)
		new_name = "CondiMaster"
		new_path = /obj/machinery/chem_master/condimaster

	build_path = new_path
	name = "[new_name] 3000 (Machine Board)"
	to_chat(user, span_notice("You change the circuit board setting to \"[new_name]\"."))
	return TRUE

/obj/item/circuitboard/machine/cryo_tube
	name = "Cryotube (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/atmospherics/components/unary/cryo_cell
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 4)

/obj/item/circuitboard/machine/fat_sucker
	name = "Lipid Extractor (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/fat_sucker
	req_components = list(/obj/item/stock_parts/micro_laser = 1,
		/obj/item/kitchen/fork = 1)

/obj/item/circuitboard/machine/harvester
	name = "Harvester (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/harvester
	req_components = list(/obj/item/stock_parts/micro_laser = 4)

/obj/item/circuitboard/machine/limbgrower
	name = "Limb Grower (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/limbgrower
	req_components = list(
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/reagent_containers/cup/beaker = 2,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/disk/data = 1
	)
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/medium
	)

/obj/item/circuitboard/machine/limbgrower/fullupgrade
	name = "Limb Grower (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/limbgrower
	req_components = list(
		/obj/item/stock_parts/manipulator/femto  = 1,
		/obj/item/reagent_containers/cup/beaker/bluespace = 2,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/disk/data = 1
	)
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/medium
	)

/obj/item/circuitboard/machine/fabricator/department/medical
	name = "Departmental Fabricator - Medical (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/rnd/production/fabricator/department/medical
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/medical
	)

/obj/item/circuitboard/machine/sleeper
	name = "Sleeper (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/sleeper
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 2)

/obj/item/circuitboard/machine/sleeper/fullupgrade
	name = "Sleeper (Machine Board)"
	icon_state = "medical"
	build_path = /obj/machinery/sleeper/syndie/fullupgrade
	req_components = list(
		/obj/item/stock_parts/matter_bin/bluespace = 1,
		/obj/item/stock_parts/manipulator/femto = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 2)

/obj/item/circuitboard/machine/sleeper/party
	name = "Party Pod (Machine Board)"
	build_path = /obj/machinery/sleeper/party

/obj/item/circuitboard/machine/sleeper/mancrowave
	name = "Thermal Homeostasis Regulator (Machine Board)"
	build_path = /obj/machinery/sleeper/mancrowave
	req_components = list(
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 2,
	)

/obj/item/circuitboard/machine/smoke_machine
	name = "Smoke Machine (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/smoke_machine
	req_components = list(
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/cell = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/stasis
	name = "\improper Lifeform Stasis Unit (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/stasis
	req_components = list(
		/obj/item/stack/cable_coil = 3,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/capacitor = 1)

/obj/item/circuitboard/machine/medipen_refiller
	name = "Medipen Refiller (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/medipen_refiller
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1)

/obj/item/circuitboard/machine/bodyscanner
	name = "Body Scanner (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/bodyscanner
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stock_parts/capacitor = 1
	)

/obj/item/circuitboard/machine/bodyscanner_console
	name = "Body Scanner Console (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/bodyscanner_console
	req_components = list(
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1
	)

/obj/item/circuitboard/machine/cyborgrecharger
	name = "Cyborg Recharger (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/recharge_station
	req_components = list(
		/obj/item/stock_parts/capacitor = 2,
		/obj/item/stock_parts/cell = 1,
		/obj/item/stock_parts/manipulator = 1)
	def_components = list(/obj/item/stock_parts/cell = /obj/item/stock_parts/cell/high)

/obj/item/circuitboard/machine/destructive_analyzer
	name = "Destructive Analyzer (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/destructive_analyzer
	req_components = list(
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/micro_laser = 1,
	)

/obj/item/circuitboard/machine/mech_recharger
	name = "Mechbay Recharger (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/mech_bay_recharge_port
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/stock_parts/capacitor = 5)

/obj/item/circuitboard/machine/monkey_recycler
	name = "Monkey Recycler (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/monkey_recycler
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/processor/slime
	name = "Slime Processor (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/processor/slime

/obj/item/circuitboard/machine/quantumpad
	name = "Quantum Pad (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/quantumpad
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/cable_coil = 1)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)

/obj/item/circuitboard/machine/teleporter_hub
	name = "Teleporter Hub (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/teleport/hub
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 3,
		/obj/item/stock_parts/matter_bin = 1)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)

/obj/item/circuitboard/machine/teleporter_station
	name = "Teleporter Station (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/teleport/station
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 2,
		/obj/item/stock_parts/capacitor = 2,
		/obj/item/stack/sheet/glass = 1)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)

/obj/item/circuitboard/machine/dnascanner
	name = "DNA Scanner (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/dna_scannernew
	req_components = list(
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/machine/mechpad
	name = "Mecha Orbital Pad (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/mechpad
	req_components = list()

/obj/item/circuitboard/machine/fabricator/department/robotics
	name = "Departmental Fabricator - Robotics (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ROBOTICS
	build_path = /obj/machinery/rnd/production/fabricator/department/robotics
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/robotics
	)

//Security

/obj/item/circuitboard/machine/fabricator/department/security
	name = "Departmental Fabricator - Security (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/rnd/production/fabricator/department/security
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/security
	)

/obj/item/circuitboard/machine/recharger
	name = "Weapon Recharger (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/recharger
	req_components = list(/obj/item/stock_parts/capacitor = 1)
	needs_anchored = FALSE

//Service

/obj/item/circuitboard/machine/biogenerator
	name = "Biogenerator (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/biogenerator
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/chem_dispenser/drinks
	name = "Soda Dispenser (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/chem_dispenser/drinks

/obj/item/circuitboard/machine/chem_dispenser/drinks/beer
	name = "Booze Dispenser (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/chem_dispenser/drinks/beer

/obj/item/circuitboard/machine/chem_master/condi
	name = "CondiMaster 3000 (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/chem_master/condimaster

/obj/item/circuitboard/machine/deep_fryer
	name = "circuit board (Deep Fryer)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/deepfryer
	req_components = list(/obj/item/stock_parts/micro_laser = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/griddle
	name = "circuit board (Griddle)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/griddle
	req_components = list(/obj/item/stock_parts/micro_laser = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/oven
	name = "circuit board (Oven)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/oven
	req_components = list(/obj/item/stock_parts/micro_laser = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/dish_drive
	name = "Dish Drive (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/dish_drive
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/matter_bin = 2)
	var/suction = TRUE
	var/transmit = TRUE
	needs_anchored = FALSE

/obj/item/circuitboard/machine/dish_drive/examine(mob/user)
	. = ..()
	. += span_notice("Its suction function is [suction ? "enabled" : "disabled"]. Use it in-hand to switch.")
	. += span_notice("Its disposal auto-transmit function is [transmit ? "enabled" : "disabled"]. Alt-click it to switch.")

/obj/item/circuitboard/machine/dish_drive/attack_self(mob/living/user)
	suction = !suction
	to_chat(user, span_notice("You [suction ? "enable" : "disable"] the board's suction function."))

/obj/item/circuitboard/machine/dish_drive/AltClick(mob/living/user)
	if(!user.Adjacent(src))
		return
	transmit = !transmit
	to_chat(user, span_notice("You [transmit ? "enable" : "disable"] the board's automatic disposal transmission."))

/obj/item/circuitboard/machine/gibber
	name = "Gibber (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/gibber
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/hydroponics
	name = "Hydroponics Tray (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/hydroponics/constructable
	req_components = list(
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/sheet/glass = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/microwave
	name = "Microwave (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/microwave
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/processor
	name = "Food Processor (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/processor
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/processor/screwdriver_act(mob/living/user, obj/item/tool)
	if(build_path == /obj/machinery/processor)
		name = "Slime Processor (Machine Board)"
		build_path = /obj/machinery/processor/slime
		to_chat(user, span_notice("Name protocols successfully updated."))
	else
		name = "Food Processor (Machine Board)"
		build_path = /obj/machinery/processor
		to_chat(user, span_notice("Defaulting name protocols."))
	return TRUE

/obj/item/circuitboard/machine/fabricator/department/service
	name = "Departmental Fabricator - Service (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/rnd/production/fabricator/department/service
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/service
	)

/obj/item/circuitboard/machine/recycler
	name = "Recycler (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/recycler
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/seed_extractor
	name = "Seed Extractor (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/seed_extractor
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/vendatray
	name = "Vend-A-Tray (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/structure/displaycase/forsale
	req_components = list(
		/obj/item/stock_parts/card_reader = 1)

//Supply

/obj/item/circuitboard/machine/mining_equipment_vendor
	name = "Mining Equipment Vendor (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/mineral/equipment_vendor
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/matter_bin = 3)

/obj/item/circuitboard/machine/mining_equipment_vendor/golem
	name = "Golem Ship Equipment Vendor (Machine Board)"
	build_path = /obj/machinery/mineral/equipment_vendor/golem

/obj/item/circuitboard/machine/ore_redemption
	name = "Ore Redemption (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/mineral/ore_redemption
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/assembly/igniter = 1,
		/obj/item/disk/data = 1,
	)
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/medium
	)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/ore_silo
	name = "Ore Silo (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/ore_silo
	req_components = list()

/obj/item/circuitboard/machine/fabricator/department/cargo
	name = "Departmental Fabricator - Cargo (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/rnd/production/fabricator/department/cargo
	def_components = list(
		/obj/item/disk/data = /obj/item/disk/data/fabricator/supply
	)

/obj/item/circuitboard/machine/stacking_machine
	name = "Stacking Machine (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/mineral/stacking_machine
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/matter_bin = 2)

/obj/item/circuitboard/machine/stacking_unit_console
	name = "Stacking Machine Console (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/mineral/stacking_unit_console
	req_components = list(
		/obj/item/stack/sheet/glass = 2,
		/obj/item/stack/cable_coil = 5)

//Misc
/obj/item/circuitboard/machine/sheetifier
	name = "Sheet-meister 2000 (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/sheetifier
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/matter_bin = 2)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/restaurant_portal
	name = "Restaurant Portal"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/restaurant_portal
	needs_anchored = TRUE

/obj/item/circuitboard/machine/abductor
	name = "alien board (Report This)"
	icon_state = "abductor_mod"

/obj/item/circuitboard/machine/abductor/core
	name = "alien board (Void Core)"
	build_path = /obj/machinery/power/rtg/abductor
	req_components = list(
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/cell/infinite/abductor = 1)
	def_components = list(
		/obj/item/stock_parts/capacitor = /obj/item/stock_parts/capacitor/quadratic,
		/obj/item/stock_parts/micro_laser = /obj/item/stock_parts/micro_laser/quadultra)

/obj/item/circuitboard/machine/hypnochair
	name = "Enhanced Interrogation Chamber (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/hypnochair
	req_components = list(
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/scanning_module = 2
	)

/obj/item/circuitboard/machine/skill_station
	name = "Skill Station (Machine Board)"
	build_path = /obj/machinery/skill_station
	req_components = list(
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/scanning_module = 2
	)

/obj/item/circuitboard/machine/doppler_array
	name = "Tachyon-Doppler Research Array (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/doppler_array
	req_components = list(
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/scanning_module = 4)

/obj/item/circuitboard/machine/exoscanner
	name = "Exoscanner (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/exoscanner
	req_components = list(
		/obj/item/stock_parts/micro_laser = 4,
		/obj/item/stock_parts/scanning_module = 4)

/obj/item/circuitboard/machine/exodrone_launcher
	name = "Exploration Drone Launcher (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/exodrone_launcher
	req_components = list(
		/obj/item/stock_parts/micro_laser = 4,
		/obj/item/stock_parts/scanning_module = 4)

/obj/item/circuitboard/machine/ecto_sniffer
	name = "Ectoscopic Sniffer (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/ecto_sniffer
	req_components = list(
		/obj/item/stock_parts/scanning_module = 1)

/obj/item/circuitboard/machine/anomaly_refinery
	name = "Anomaly Refinery (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/research/anomaly_refinery
	req_components = list(
		/obj/item/stack/sheet/plasteel = 15,
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stock_parts/manipulator = 1,
		)

/obj/item/circuitboard/machine/tank_compressor
	name = "Tank Compressor (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/atmospherics/components/binary/tank_compressor
	req_components = list(
		/obj/item/stack/sheet/plasteel = 5,
		/obj/item/stock_parts/scanning_module = 4,
		)
