/obj/item/vending_refill/wardrobe
	icon_state = "refill_clothes"

/obj/machinery/vending/wardrobe
	default_price = PAYCHECK_ASSISTANT * 0.8
	extra_price = PAYCHECK_HARD
	payment_department = NO_FREEBIES
	input_display_header = "Returned Clothing"
	panel_type = "panel19"
	light_mask = "wardrobe-light-mask"

/obj/machinery/vending/wardrobe/sec_wardrobe
	name = "\improper SecDrobe"
	desc = "A vending machine for security and security-related clothing!"
	icon_state = "secdrobe"
	product_ads = "Beat perps in style!;It's red so you can't see the blood!;You have the right to be fashionable!;Now you can be the fashion police you always wanted to be!"
	vend_reply = "Thank you for using the SecDrobe!"
	products = list(/obj/item/clothing/suit/hooded/wintercoat/security = 3,
					/obj/item/storage/backpack/security = 3,
					/obj/item/storage/backpack/satchel/sec = 3,
					/obj/item/storage/backpack/duffelbag/sec = 3,
					/obj/item/clothing/shoes/jackboots = 3,
					/obj/item/clothing/under/rank/security/officer = 3,
					/obj/item/clothing/under/rank/security/officer/garrison = 3,
					/obj/item/clothing/head/garrison_cap = 3,
					/obj/item/clothing/head/soft/sec = 3,
					/obj/item/clothing/mask/bandana/striped/security = 3,
					/obj/item/clothing/gloves/color/black = 3,
					/obj/item/clothing/under/pants/khaki = 3,
					/obj/item/clothing/under/rank/security/officer/blueshirt = 3)
	refill_canister = /obj/item/vending_refill/wardrobe/sec_wardrobe
	payment_department = ACCOUNT_SEC
	light_color = COLOR_MOSTLY_PURE_RED

	discount_access = ACCESS_SECURITY

/obj/item/vending_refill/wardrobe/sec_wardrobe
	machine_name = "SecDrobe"

/obj/machinery/vending/wardrobe/medi_wardrobe
	name = "\improper MediDrobe"
	desc = "A vending machine rumoured to be capable of dispensing clothing for medical personnel."
	icon_state = "medidrobe"
	product_ads = "Make those blood stains look fashionable!!"
	vend_reply = "Thank you for using the MediDrobe!"
	products = list(/obj/item/clothing/accessory/pocketprotector = 4,
					/obj/item/storage/backpack/duffelbag/med = 4,
					/obj/item/storage/backpack/medic = 4,
					/obj/item/storage/backpack/satchel/med = 4,
					/obj/item/clothing/suit/hooded/wintercoat/medical = 4,
					/obj/item/clothing/suit/hooded/wintercoat/medical/paramedic = 4,
					/obj/item/clothing/under/rank/medical/paramedic = 4,
					/obj/item/clothing/under/rank/medical/paramedic/skirt = 4,
					/obj/item/clothing/head/nursehat = 4,
					/obj/item/clothing/head/beret/medical = 4,
					/obj/item/clothing/mask/bandana/striped/medical = 4,
					/obj/item/clothing/under/rank/medical/doctor = 4,
					/obj/item/clothing/under/rank/medical/doctor/skirt = 4,
					/obj/item/clothing/under/rank/medical/scrubs/blue = 4,
					/obj/item/clothing/under/rank/medical/scrubs/green = 4,
					/obj/item/clothing/under/rank/medical/scrubs/purple = 4,
					/obj/item/clothing/suit/toggle/labcoat/md = 4,
					/obj/item/clothing/suit/toggle/labcoat/paramedic = 4,
					/obj/item/clothing/shoes/sneakers/white = 4,
					/obj/item/clothing/head/beret/medical/paramedic = 4,
					/obj/item/clothing/head/soft/paramedic = 4,
					/obj/item/clothing/shoes/really_blue_sneakers = 4,
					/obj/item/clothing/suit/apron/surgical = 4,
					/obj/item/clothing/mask/surgical = 4)
	refill_canister = /obj/item/vending_refill/wardrobe/medi_wardrobe
	payment_department = ACCOUNT_MED

	discount_access = ACCESS_MEDICAL

/obj/item/vending_refill/wardrobe/medi_wardrobe
	machine_name = "MediDrobe"

/obj/machinery/vending/wardrobe/engi_wardrobe
	name = "EngiDrobe"
	desc = "A vending machine renowned for vending industrial grade clothing."
	icon_state = "engidrobe"
	product_ads = "Guaranteed to protect your feet from industrial accidents!;Afraid of radiation? Then wear yellow!"
	vend_reply = "Thank you for using the EngiDrobe!"
	products = list(/obj/item/clothing/accessory/pocketprotector = 3,
					/obj/item/storage/backpack/duffelbag/engineering = 3,
					/obj/item/storage/backpack/industrial = 3,
					/obj/item/storage/backpack/satchel/eng = 3,
					/obj/item/clothing/suit/hooded/wintercoat/engineering = 3,
					/obj/item/clothing/under/rank/engineering/engineer = 3,
					/obj/item/clothing/under/rank/engineering/engineer/skirt = 3,
					/obj/item/clothing/under/rank/engineering/engineer/hazard = 3,
					/obj/item/clothing/under/rank/engineering/engineer/enginetech = 3,
					/obj/item/clothing/under/rank/engineering/engineer/enginetech/skirt = 3,
					/obj/item/clothing/under/rank/engineering/engineer/electrician = 3,
					/obj/item/clothing/under/rank/engineering/engineer/electrician/skirt = 3,
					/obj/item/clothing/suit/hazardvest = 3,
					/obj/item/clothing/shoes/workboots = 3,
					/obj/item/clothing/head/beret/engi = 3,
					/obj/item/clothing/mask/bandana/striped/engineering = 3,
					/obj/item/clothing/head/hardhat = 3,
					/obj/item/clothing/head/hardhat/weldhat = 3)
	refill_canister = /obj/item/vending_refill/wardrobe/engi_wardrobe
	payment_department = ACCOUNT_ENG
	light_color = COLOR_VIVID_YELLOW

	discount_access = ACCESS_ENGINEERING
/obj/item/vending_refill/wardrobe/engi_wardrobe
	machine_name = "EngiDrobe"

/obj/machinery/vending/wardrobe/atmos_wardrobe
	name = "AtmosDrobe"
	desc = "This relatively unknown vending machine delivers clothing for Atmospherics Technicians, an equally unknown job."
	icon_state = "atmosdrobe"
	product_ads = "Get your inflammable clothing right here!!!"
	vend_reply = "Thank you for using the AtmosDrobe!"
	products = list(/obj/item/clothing/accessory/pocketprotector = 2,
					/obj/item/storage/backpack/duffelbag/engineering = 2,
					/obj/item/storage/backpack/satchel/eng = 2,
					/obj/item/storage/backpack/industrial = 2,
					/obj/item/clothing/suit/hooded/wintercoat/engineering/atmos = 3,
					/obj/item/clothing/under/rank/engineering/atmospheric_technician = 3,
					/obj/item/clothing/under/rank/engineering/atmospheric_technician/skirt = 3,
					/obj/item/clothing/head/beret/atmos = 3,
					/obj/item/clothing/shoes/sneakers/black = 3)
	refill_canister = /obj/item/vending_refill/wardrobe/atmos_wardrobe
	payment_department = ACCOUNT_ENG
	light_color = COLOR_VIVID_YELLOW

	discount_access = ACCESS_ATMOSPHERICS

/obj/item/vending_refill/wardrobe/atmos_wardrobe
	machine_name = "AtmosDrobe"

/obj/machinery/vending/wardrobe/cargo_wardrobe
	name = "CargoDrobe"
	desc = "A highly advanced vending machine for buying cargo related clothing for free."
	icon_state = "cargodrobe"
	product_ads = "Upgraded Assistant Style! Pick yours today!;These shorts are comfy and easy to wear, get yours now!"
	vend_reply = "Thank you for using the CargoDrobe!"
	products = list(
		/obj/item/storage/bag/mail = 3,
		/obj/item/clothing/suit/hooded/wintercoat/cargo = 3,
		/obj/item/clothing/under/rank/cargo/tech = 3,
		/obj/item/clothing/under/rank/cargo/tech/skirt = 3,
		/obj/item/clothing/shoes/sneakers/black = 3,
		/obj/item/clothing/gloves/fingerless = 3,
		/obj/item/clothing/head/beret/cargo = 3,
		/obj/item/clothing/mask/bandana/striped/cargo = 3,
		/obj/item/clothing/head/soft = 3,
		/obj/item/radio/headset/headset_cargo = 3
	)
	premium = list(
		/obj/item/clothing/under/rank/cargo/miner = 3,
		/obj/item/clothing/head/mailman = 1,
		/obj/item/clothing/under/misc/mailman = 1
	)
	refill_canister = /obj/item/vending_refill/wardrobe/cargo_wardrobe
	payment_department = ACCOUNT_CAR

	discount_access = ACCESS_CARGO

/obj/item/vending_refill/wardrobe/cargo_wardrobe
	machine_name = "CargoDrobe"

/obj/machinery/vending/wardrobe/robo_wardrobe
	name = "RoboDrobe"
	desc = "A vending machine designed to dispense clothing known only to roboticists."
	icon_state = "robodrobe"
	product_ads = "You turn me TRUE, use defines!;0110001101101100011011110111010001101000011001010111001101101000011001010111001001100101"
	vend_reply = "Thank you for using the RoboDrobe!"
	products = list(/obj/item/clothing/glasses/hud/diagnostic = 2,
					/obj/item/clothing/under/rank/rnd/roboticist = 2,
					/obj/item/clothing/under/rank/rnd/roboticist/skirt = 2,
					/obj/item/clothing/suit/toggle/labcoat/roboticist = 2,
					/obj/item/clothing/suit/hooded/wintercoat/science/robotics = 3,
					/obj/item/clothing/shoes/sneakers/black = 2,
					/obj/item/clothing/gloves/fingerless = 2,
					/obj/item/clothing/head/soft/black = 2,
					/obj/item/clothing/mask/bandana/skull/black = 2)
	contraband = list(/obj/item/clothing/suit/hooded/techpriest = 2,
					  /obj/item/clothing/under/costume/mech_suit = 2,
					  /obj/item/organ/tongue/robot = 2)
	refill_canister = /obj/item/vending_refill/wardrobe/robo_wardrobe
	extra_price = PAYCHECK_HARD * 1.2
	payment_department = ACCOUNT_STATION_MASTER

	discount_access = ACCESS_ROBOTICS
/obj/item/vending_refill/wardrobe/robo_wardrobe
	machine_name = "RoboDrobe"

/obj/machinery/vending/wardrobe/science_wardrobe
	name = "SciDrobe"
	desc = "A simple vending machine suitable to dispense well tailored science clothing. Endorsed by Space Cubans."
	icon_state = "scidrobe"
	product_ads = "Longing for the smell of plasma burnt flesh? Buy your science clothing now!;Made with 10% Auxetics, so you don't have to worry about losing your arm!"
	vend_reply = "Thank you for using the SciDrobe!"
	products = list(/obj/item/clothing/accessory/pocketprotector = 3,
					/obj/item/storage/backpack/science = 3,
					/obj/item/storage/backpack/satchel/science = 3,
					/obj/item/storage/backpack/duffelbag/science = 3,
					/obj/item/clothing/head/beret/science = 3,
					/obj/item/clothing/head/beret/science/fancy = 3,
					/obj/item/clothing/mask/bandana/striped/science = 3,
					/obj/item/clothing/suit/hooded/wintercoat/science = 3,
					/obj/item/clothing/under/rank/rnd/scientist = 3,
					/obj/item/clothing/under/rank/rnd/scientist/skirt = 3,
					/obj/item/clothing/suit/toggle/labcoat/science = 3,
					/obj/item/clothing/suit/overalls_sci = 3,
					/obj/item/clothing/shoes/sneakers/white = 3,
					/obj/item/clothing/mask/gas = 3)
	refill_canister = /obj/item/vending_refill/wardrobe/science_wardrobe
	payment_department = ACCOUNT_STATION_MASTER

	discount_access = ACCESS_RESEARCH
/obj/item/vending_refill/wardrobe/science_wardrobe
	machine_name = "SciDrobe"

/obj/machinery/vending/wardrobe/hydro_wardrobe
	name = "Hydrobe"
	desc = "A machine with a catchy name. It dispenses botany related clothing and gear."
	icon_state = "hydrobe"
	product_ads = "Do you love soil? Then buy our clothes!;Get outfits to match your green thumb here!"
	vend_reply = "Thank you for using the Hydrobe!"
	products = list(/obj/item/storage/backpack/botany = 2,
					/obj/item/storage/backpack/satchel/hyd = 2,
					/obj/item/storage/backpack/duffelbag/hydroponics = 2,
					/obj/item/clothing/suit/hooded/wintercoat/hydro = 2,
					/obj/item/clothing/suit/apron = 2,
					/obj/item/clothing/suit/apron/overalls = 3,
					/obj/item/clothing/suit/apron/waders = 3,
					/obj/item/clothing/under/rank/civilian/hydroponics = 3,
					/obj/item/clothing/under/rank/civilian/hydroponics/skirt = 3,
					/obj/item/clothing/mask/bandana/striped/botany = 3,
					/obj/item/clothing/accessory/armband/hydro = 3)
	refill_canister = /obj/item/vending_refill/wardrobe/hydro_wardrobe
	payment_department = ACCOUNT_STATION_MASTER
	light_color = LIGHT_COLOR_ELECTRIC_GREEN

	discount_access = ACCESS_HYDROPONICS

/obj/item/vending_refill/wardrobe/hydro_wardrobe
	machine_name = "HyDrobe"

/obj/machinery/vending/wardrobe/curator_wardrobe
	name = "CuraDrobe"
	desc = "A lowstock vendor only capable of vending clothing for curators and librarians."
	icon_state = "curadrobe"
	product_ads = "Glasses for your eyes and literature for your soul, Curadrobe has it all!; Impress & enthrall your library guests with Curadrobe's extended line of pens!"
	vend_reply = "Thank you for using the CuraDrobe!"
	products = list(/obj/item/pen = 4,
					/obj/item/pen/red = 2,
					/obj/item/pen/blue = 2,
					/obj/item/pen/fourcolor = 1,
					/obj/item/pen/fountain = 2,
					/obj/item/clothing/accessory/pocketprotector = 2,
					/obj/item/clothing/under/rank/civilian/curator = 1,
					/obj/item/clothing/under/rank/civilian/curator/skirt = 1,
					/obj/item/clothing/under/rank/captain/suit = 1,
					/obj/item/clothing/under/rank/captain/suit/skirt = 1,
					/obj/item/clothing/under/rank/civilian/head_of_personnel/suit = 1,
					/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt = 1,
					/obj/item/storage/backpack/satchel/explorer = 1,
					/obj/item/clothing/glasses/regular = 2,
					/obj/item/clothing/glasses/regular/jamjar = 1,
					/obj/item/storage/bag/books = 1)
	refill_canister = /obj/item/vending_refill/wardrobe/curator_wardrobe
	payment_department = ACCOUNT_STATION_MASTER

	discount_access = ACCESS_LIBRARY

/obj/item/vending_refill/wardrobe/curator_wardrobe
	machine_name = "CuraDrobe"

/obj/machinery/vending/wardrobe/bar_wardrobe
	name = "BarDrobe"
	desc = "A stylish vendor to dispense the most stylish bar clothing!"
	icon_state = "bardrobe"
	product_ads = "Guaranteed to prevent stains from spilled drinks!"
	vend_reply = "Thank you for using the BarDrobe!"
	products = list(/obj/item/clothing/head/that = 2,
					/obj/item/radio/headset/headset_srv = 2,
					/obj/item/clothing/under/suit/sl = 2,
					/obj/item/clothing/under/rank/civilian/bartender = 2,
					/obj/item/clothing/under/rank/civilian/bartender/purple = 2,
					/obj/item/clothing/under/rank/civilian/bartender/skirt = 2,
					/obj/item/clothing/accessory/waistcoat = 2,
					/obj/item/clothing/suit/apron/purple_bartender = 2,
					/obj/item/clothing/head/soft/black = 2,
					/obj/item/clothing/shoes/sneakers/black = 2,
					/obj/item/reagent_containers/cup/rag = 2,
					/obj/item/storage/box/beanbag = 1,
					/obj/item/clothing/suit/armor/vest/ballistic = 1,
					/obj/item/circuitboard/machine/dish_drive = 1,
					/obj/item/clothing/glasses/sunglasses/reagent = 1,
					/obj/item/clothing/neck/petcollar = 1,
					/obj/item/storage/belt/bandolier = 1,
					/obj/item/storage/dice/hazard = 1,
					/obj/item/storage/bag/money = 2)
	premium = list(/obj/item/storage/box/dishdrive = 1)
	refill_canister = /obj/item/vending_refill/wardrobe/bar_wardrobe
	payment_department = ACCOUNT_STATION_MASTER
	extra_price = PAYCHECK_HARD

	discount_access = ACCESS_BAR

/obj/item/vending_refill/wardrobe/bar_wardrobe
	machine_name = "BarDrobe"

/obj/machinery/vending/wardrobe/chef_wardrobe
	name = "ChefDrobe"
	desc = "This vending machine might not dispense meat, but it certainly dispenses chef related clothing."
	icon_state = "chefdrobe"
	product_ads = "Our clothes are guaranteed to protect you from food splatters!"
	vend_reply = "Thank you for using the ChefDrobe!"
	products = list(/obj/item/clothing/under/suit/waiter = 2,
					/obj/item/radio/headset/headset_srv = 2,
					/obj/item/clothing/accessory/waistcoat = 2,
					/obj/item/clothing/suit/apron/chef = 3,
					/obj/item/clothing/head/soft/mime = 2,
					/obj/item/storage/box/mousetraps = 2,
					/obj/item/circuitboard/machine/dish_drive = 1,
					/obj/item/clothing/suit/toggle/chef = 1,
					/obj/item/clothing/under/rank/civilian/chef = 1,
					/obj/item/clothing/under/rank/civilian/chef/skirt = 2,
					/obj/item/clothing/head/chefhat = 1,
					/obj/item/clothing/under/rank/civilian/cookjorts = 2,
					/obj/item/clothing/shoes/cookflops = 2,
					/obj/item/reagent_containers/cup/rag = 1,
					/obj/item/clothing/suit/hooded/wintercoat = 2)
	refill_canister = /obj/item/vending_refill/wardrobe/chef_wardrobe
	payment_department = ACCOUNT_STATION_MASTER

	discount_access = ACCESS_KITCHEN

/obj/item/vending_refill/wardrobe/chef_wardrobe
	machine_name = "ChefDrobe"

/obj/machinery/vending/wardrobe/jani_wardrobe
	name = "JaniDrobe"
	desc = "A self cleaning vending machine capable of dispensing clothing for janitors."
	icon_state = "janidrobe"
	product_ads = "Come and get your janitorial clothing, now endorsed by Jinan janitors everywhere!"
	vend_reply = "Thank you for using the JaniDrobe!"

	products = list(
		/obj/item/clothing/under/rank/civilian/janitor = 2,
		/obj/item/clothing/under/rank/civilian/janitor/skirt = 2,
		/obj/item/clothing/suit/hooded/wintercoat/janitor = 2,
		/obj/item/clothing/gloves/cleaning = 2,
		/obj/item/clothing/head/soft/purple = 2,
		/obj/item/clothing/mask/bandana/purple = 2,
		/obj/item/pushbroom = 2,
		/obj/item/paint_remover = 2,
		/obj/item/melee/flyswatter = 2,
		/obj/item/flashlight = 2,
		/obj/item/clothing/suit/caution = 6,
		/obj/item/holosign_creator = 2,
		/obj/item/lightreplacer = 2,
		/obj/item/soap/nanotrasen = 2,
		/obj/item/storage/bag/trash = 2,
		/obj/item/clothing/shoes/galoshes = 1,
		/obj/item/watertank/janitor = 1,
		/obj/item/storage/belt/janitor = 2
	)

	refill_canister = /obj/item/vending_refill/wardrobe/jani_wardrobe
	default_price = PAYCHECK_ASSISTANT * 0.8
	extra_price = PAYCHECK_HARD * 0.8
	payment_department = ACCOUNT_STATION_MASTER
	light_color = COLOR_STRONG_MAGENTA

	discount_access = ACCESS_JANITOR

/obj/item/vending_refill/wardrobe/jani_wardrobe
	machine_name = "JaniDrobe"

/obj/machinery/vending/wardrobe/law_wardrobe
	name = "LawDrobe"
	desc = "Objection! This wardrobe dispenses the rule of law... and lawyer clothing."
	icon_state = "lawdrobe"
	product_ads = "OBJECTION! Get the rule of law for yourself!"
	vend_reply = "Thank you for using the LawDrobe!"
	products = list(/obj/item/clothing/under/rank/civilian/lawyer/bluesuit = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/bluesuit/skirt = 1,
					/obj/item/clothing/suit/toggle/lawyer = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/purpsuit = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/purpsuit/skirt = 1,
					/obj/item/clothing/suit/toggle/lawyer/purple = 1,
					/obj/item/clothing/under/suit/black = 1,
					/obj/item/clothing/under/suit/black/skirt = 1,
					/obj/item/clothing/suit/toggle/lawyer/black = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/beige = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/beige/skirt = 1,
					/obj/item/clothing/under/suit/black_really = 1,
					/obj/item/clothing/under/suit/black_really/skirt = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/blue = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/blue/skirt = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/red = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/red/skirt = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/black = 1,
					/obj/item/clothing/under/rank/civilian/lawyer/black/skirt = 1,
					/obj/item/clothing/shoes/laceup = 2,
					/obj/item/clothing/accessory/lawyers_badge = 2)
	refill_canister = /obj/item/vending_refill/wardrobe/law_wardrobe
	payment_department = ACCOUNT_STATION_MASTER

	discount_access = ACCESS_LAWYER

/obj/item/vending_refill/wardrobe/law_wardrobe
	machine_name = "LawDrobe"

/obj/machinery/vending/wardrobe/chap_wardrobe
	name = "DeusVend"
	desc = "God wills your purchase."
	icon_state = "chapdrobe"
	product_ads = "Are you being bothered by cultists or pesky revenants? Then come and dress like the holy man!;Clothes for men of the cloth!"
	vend_reply = "Thank you for using the DeusVend!"
	products = list(/obj/item/choice_beacon/holy = 1,
					/obj/item/storage/backpack/cultpack = 1,
					/obj/item/clothing/accessory/pocketprotector/cosmetology = 1,
					/obj/item/clothing/under/rank/civilian/chaplain = 1,
					/obj/item/clothing/under/rank/civilian/chaplain/skirt = 2,
					/obj/item/clothing/shoes/sneakers/black = 1,
					/obj/item/clothing/suit/chaplainsuit/nun = 1,
					/obj/item/clothing/head/nun_hood = 1,
					/obj/item/clothing/suit/chaplainsuit/holidaypriest = 1,
					/obj/item/clothing/suit/hooded/chaplainsuit/monkhabit = 1,
					/obj/item/storage/fancy/candle_box = 2,
					/obj/item/clothing/head/kippah = 3,
					/obj/item/clothing/suit/chaplainsuit/whiterobe = 1,
					/obj/item/clothing/head/taqiyahwhite = 1,
					/obj/item/clothing/head/taqiyahred = 3,
					/obj/item/clothing/suit/chaplainsuit/monkrobeeast = 1,
					/obj/item/clothing/head/beanie/rasta = 1)
	contraband = list(/obj/item/toy/plush/ratplush = 1,
					/obj/item/toy/plush/narplush = 1,
					/obj/item/clothing/head/medievaljewhat = 3,
					/obj/item/clothing/suit/chaplainsuit/clownpriest = 1,
					/obj/item/clothing/head/clownmitre = 1)
	premium = list(/obj/item/clothing/suit/chaplainsuit/bishoprobe = 1,
					/obj/item/clothing/head/bishopmitre = 1)
	refill_canister = /obj/item/vending_refill/wardrobe/chap_wardrobe
	payment_department = ACCOUNT_STATION_MASTER

	discount_access = ACCESS_CHAPEL_OFFICE

/obj/item/vending_refill/wardrobe/chap_wardrobe
	machine_name = "DeusVend"

/obj/machinery/vending/wardrobe/chem_wardrobe
	name = "ChemDrobe"
	desc = "A vending machine for dispensing chemistry related clothing."
	icon_state = "chemdrobe"
	product_ads = "Our clothes are 0.5% more resistant to acid spills! Get yours now!"
	vend_reply = "Thank you for using the ChemDrobe!"
	products = list(
		/obj/item/clothing/under/rank/medical/chemist = 2,
		/obj/item/clothing/under/rank/medical/chemist/skirt = 2,
		/obj/item/clothing/head/beret/medical = 2,
		/obj/item/clothing/shoes/sneakers/white = 2,
		/obj/item/clothing/suit/toggle/labcoat/chemist = 2,
		/obj/item/clothing/suit/hooded/wintercoat/medical/chemistry = 2,
		/obj/item/storage/backpack/chemistry = 2,
		/obj/item/storage/backpack/satchel/chem = 2,
		/obj/item/storage/backpack/duffelbag/chemistry = 2,
		/obj/item/storage/bag/chemistry = 2,
	)
	contraband = list(/obj/item/reagent_containers/spray/syndicate = 2)
	refill_canister = /obj/item/vending_refill/wardrobe/chem_wardrobe
	payment_department = ACCOUNT_MED

	discount_access = ACCESS_PHARMACY

/obj/item/vending_refill/wardrobe/chem_wardrobe
	machine_name = "ChemDrobe"

/obj/machinery/vending/wardrobe/gene_wardrobe
	name = "GeneDrobe"
	desc = "A machine for dispensing clothing related to genetics."
	icon_state = "genedrobe"
	product_ads = "Perfect for the mad scientist in you!"
	vend_reply = "Thank you for using the GeneDrobe!"
	products = list(
		/obj/item/clothing/under/rank/rnd/geneticist = 2,
		/obj/item/clothing/under/rank/rnd/geneticist/skirt = 2,
		/obj/item/clothing/shoes/sneakers/white = 2,
		/obj/item/clothing/suit/toggle/labcoat/genetics = 2,
		/obj/item/clothing/suit/hooded/wintercoat/science/genetics = 2,
		/obj/item/storage/backpack/genetics = 2,
		/obj/item/storage/backpack/satchel/gen = 2,
		/obj/item/storage/backpack/duffelbag/genetics = 2
	)
	refill_canister = /obj/item/vending_refill/wardrobe/gene_wardrobe
	payment_department = ACCOUNT_STATION_MASTER

	discount_access = ACCESS_GENETICS

/obj/item/vending_refill/wardrobe/gene_wardrobe
	machine_name = "GeneDrobe"

/obj/machinery/vending/wardrobe/viro_wardrobe
	name = "ViroDrobe"
	desc = "An unsterilized machine for dispending virology related clothing."
	icon_state = "virodrobe"
	product_ads = " Viruses getting you down? Then upgrade to sterilized clothing today!"
	vend_reply = "Thank you for using the ViroDrobe"
	products = list(/obj/item/clothing/under/rank/medical/virologist = 2,
					/obj/item/clothing/under/rank/medical/virologist/skirt = 2,
					/obj/item/clothing/head/beret/medical = 2,
					/obj/item/clothing/shoes/sneakers/white = 2,
					/obj/item/clothing/suit/toggle/labcoat/virologist = 2,
					/obj/item/clothing/suit/hooded/wintercoat/medical/viro = 2,
					/obj/item/clothing/mask/surgical = 2,
					/obj/item/storage/backpack/virology = 2,
					/obj/item/storage/backpack/satchel/vir = 2,
					/obj/item/storage/backpack/duffelbag/virology = 2)
	refill_canister = /obj/item/vending_refill/wardrobe/viro_wardrobe
	payment_department = ACCOUNT_MED

	discount_access = ACCESS_MEDICAL

/obj/item/vending_refill/wardrobe/viro_wardrobe
	machine_name = "ViroDrobe"

/obj/machinery/vending/wardrobe/det_wardrobe
	name = "\improper DetDrobe"
	desc = "A machine for all your detective needs, as long as you need clothes."
	icon_state = "detdrobe"
	product_ads = "Apply your brilliant deductive methods in style!"
	vend_reply = "Thank you for using the DetDrobe!"
	products = list(/obj/item/clothing/under/rank/security/detective = 2,
					/obj/item/clothing/under/rank/security/detective/skirt = 2,
					/obj/item/clothing/shoes/sneakers/brown = 2,
					/obj/item/clothing/suit/det_suit = 2,
					/obj/item/clothing/under/rank/security/detective/noir = 2,
					/obj/item/clothing/under/rank/security/detective/noir/skirt = 2,
					/obj/item/clothing/accessory/waistcoat = 2,
					/obj/item/clothing/shoes/laceup = 2,
					/obj/item/clothing/suit/det_suit/dark = 1,
					/obj/item/clothing/suit/det_suit/noir = 1,
					/obj/item/clothing/head/fedora = 2,
					/obj/item/clothing/gloves/color/black = 2,
					/obj/item/clothing/gloves/color/latex = 2,
					/obj/item/clothing/suit/toggle/labcoat/forensic = 2,
					/obj/item/clothing/under/rank/security/detective/disco = 1,
					/obj/item/clothing/suit/det_suit/disco = 1,
					/obj/item/clothing/shoes/discoshoes = 1,
					/obj/item/clothing/neck/tie/disco = 1,
					/obj/item/clothing/under/rank/security/detective/kim = 1,
					/obj/item/clothing/suit/det_suit/kim = 1,
					/obj/item/clothing/shoes/kim = 1,
					/obj/item/clothing/gloves/kim = 1,
					/obj/item/clothing/glasses/regular/kim = 1,
					/obj/item/reagent_containers/cup/glass/flask/det = 2,
					/obj/item/storage/fancy/cigarettes = 5)
	premium = list(/obj/item/clothing/head/flatcap = 1)
	refill_canister = /obj/item/vending_refill/wardrobe/det_wardrobe
	extra_price = PAYCHECK_ASSISTANT * 4
	payment_department = ACCOUNT_SEC

	discount_access = ACCESS_FORENSICS

/obj/item/vending_refill/wardrobe/det_wardrobe
	machine_name = "DetDrobe"
