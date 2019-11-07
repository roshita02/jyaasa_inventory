# frozen_string_literal: true

# Rake task for seeding
namespace :load_item do
  task :item_list => :environment do
    # Custom item and categories list for seeding
    office_equipment = Category.find_or_create_by(name: 'OFFICE EQUIPMENT', depreciation_rate: '25', type: 'FixedItemCategory')
    furniture = Category.find_or_create_by(name: 'FURNITURE & FIXTURES', depreciation_rate: '25', type: 'FixedItemCategory' )
    land = Category.find_or_create_by(name: 'LAND & DEVELOPMENTS', depreciation_rate: '5', type: 'FixedItemCategory')
    stationaries = Category.find_or_create_by(name: 'STATIONARIES', type: 'NonFixedItemCategory')
    cleaning = Category.find_or_create_by(name: 'CLEANING & SANITATION', type: 'NonFixedItemCategory')
    accessories = Category.find_or_create_by(name: 'ACCESSORIES', type: 'NonFixedItemCategory')
    groceries = Category.find_or_create_by(name: 'GROCERIES', type: 'NonFixedItemCategory')
    firstaid = Category.find_or_create_by(name: 'FIRST AID', type: 'NonFixedItemCategory')

    office_equipment_items = [
      { name: 'LAPTOP', type: 'FixedItem' },
      { name: 'IMAC', type: 'FixedItem' },
      { name: 'MACBOOK', type: 'FixedItem' },
      { name: 'DESKTOP COMPUTER', type: 'FixedItem' },
      { name: 'MONITOR', type: 'FixedItem' },
      { name: 'NUC', type: 'FixedItem' },
      { name: 'TV', type: 'FixedItem' },
      { name: 'KEYBOARD', type: 'FixedItem' },
      { name: 'MOUSE', type: 'FixedItem' },
      { name: 'EXTENSION CORD', type: 'FixedItem' },
      { name: 'PROJECTOR', type: 'FixedItem' },
      { name: 'SPEAKER', type: 'FixedItem' },
      { name: 'MICROPHONE', type: 'FixedItem' },
      { name: 'ELECTRIC STAND FAN', type: 'FixedItem' },
      { name: 'WATER COOLER', type: 'FixedItem' },
      { name: 'WALL HEATER', type: 'FixedItem' },
      { name: 'STAND HEATER', type: 'FixedItem' },
      { name: 'MOBILE', type: 'FixedItem' },
      { name: 'GAS CYLINDER', type: 'FixedItem' },
      { name: 'GAS HEATER', type: 'FixedItem' },
      { name: 'CHROMECAST',type: 'FixedItem' },
      { name: 'WIRELESS SPEAKER', type: 'FixedItem' },
      { name: 'PRINTER', type: 'FixedItem' },
      { name: 'MONITOR STAND', type: 'FixedItem' },
      { name: 'CLOCK', type: 'FixedItem' },
      { name: 'MOUSE PAD', type: 'FixedItem' },
      { name: 'PENDRIVE', type: 'FixedItem' },
      { name: 'SD CARD', type: 'FixedItem' },
      { name: 'CHARGER', type: 'FixedItem' },
      { name: 'LIQUID BATTERY', type: 'FixedItem' },
      { name: 'VACUUM CLEANER', type: 'FixedItem' }
    ]
    furniture_items = [
      { name: 'TABLE', type: 'FixedItem' }, { name: 'CHAIR', type: 'FixedItem' },
      { name: 'TOOLS', type: 'FixedItem' }, { name: 'CUPBOARD', type: 'FixedItem' },
      { name: 'FILE RACK', type: 'FixedItem' }, { name: 'OFFICE PARTITION', type: 'FixedItem' },
      { name: 'BOX', type: 'FixedItem' },
    ]
    land_items = [
      { name: 'LAND', type: 'FixedItem' }, { name: 'DEVELOPMENT WORKS' }
    ]

    office_equipment_items.each { |item| office_equipment.items.find_or_create_by item }
    furniture_items.each { |item| furniture.items.find_or_create_by item }
    land_items.each { |item| land.items.find_or_create_by item }

    stationary_items = [
      { name: 'SPIRAL DIARY', type: 'NonFixedItem' },
      { name: 'SPIRAL MINI NOTEBOOK', type: 'NonFixedItem' },
      { name: 'COPY', type: 'NonFixedItem' },
      { name: 'DIARY', type: 'NonFixedItem' },
      { name: 'BALL PEN', type: 'NonFixedItem' },
      { name: 'PILOT PEN', type: 'NonFixedItem' },
      { name: 'PENCIL', type: 'NonFixedItem' },
      { name: 'ERASER', type: 'NonFixedItem' },
      { name: 'SHARPNER', type: 'NonFixedItem' },
      { name: 'PHOTOCOPY PAPER', type: 'NonFixedItem' },
      { name: 'SIGN PEN / COLOR PEN', type: 'NonFixedItem' },
      { name: 'PERMANENT MARKER', type: 'NonFixedItem' },
      { name: 'BOARD MARKER', type: 'NonFixedItem' },
      { name: 'STICKY NOTES', type: 'NonFixedItem' },
      { name: 'GLUE STICK', type: 'NonFixedItem' },
      { name: 'STAPLER', type: 'NonFixedItem' },
      { name: 'STAPLE / PIN', type: 'NonFixedItem' },
      { name: 'NEPALI FILE', type: 'NonFixedItem' },
      { name: 'INDEX / VERTEX FILE', type: 'NonFixedItem' },
      { name: 'CARBON PAPER', type: 'NonFixedItem' },
      { name: 'STICKY TAPES', type: 'NonFixedItem' },
      { name: 'ENVELOPE', type: 'NonFixedItem' },
      { name: 'LETTER PAD/HEAD', type: 'NonFixedItem' },
      { name: 'MASKING TAPE', type: 'NonFixedItem' },
      { name: 'META CARDS', type: 'NonFixedItem' },
      { name: 'COLOUR PAPER', type: 'NonFixedItem' },
      { name: 'PUNCHING MACHINE', type: 'NonFixedItem' },
      { name: 'CALCULATOR', type: 'NonFixedItem' },
      { name: 'PAPER CUTTER', type: 'NonFixedItem' },
      { name: 'SCALE', type: 'NonFixedItem' },
      { name: 'CLIP / PIN', type: 'NonFixedItem' },
      { name: 'INK', type: 'NonFixedItem' },
      { name: 'TABLE FILE RACK', type: 'NonFixedItem' },
      { name: 'TEXTLINER / HIGHLIGHTER', type: 'NonFixedItem' },
      { name: 'SCISSORS', type: 'NonFixedItem' },
      { name: 'WRITING BOARD / EXAM BOARD', type: 'NonFixedItem' },
      { name: 'CLEAR BAG', type: 'NonFixedItem' },
      { name: 'PENDRIVE', type: 'NonFixedItem' },
      { name: 'DUSTER', type: 'NonFixedItem' },
      { name: 'STAMP PAD',type: 'NonFixedItem' },
      { name: 'CARTAGE & TONER', type: 'NonFixedItem' },
      { name: 'CORRECTION PEN', type: 'NonFixedItem' },
      { name: 'PAPER CLIP', type: 'NonFixedItem' },
      { name: 'BOOKS', type: 'NonFixedItem' }
    ]
    cleaning_items = [
      { name: 'BATHROOM FRESHNER', type: 'NonFixedItem' },
      { name: 'DETTOL SOAP', type: 'NonFixedItem' },
      { name: 'TOILET CLEANER / HARPIC', type: 'NonFixedItem' },
      { name: 'HOUSEHOLD CLEANER / COLIN', type: 'NonFixedItem' },
      { name: 'TOILET CLEANER', type: 'NonFixedItem' },
      { name: 'WASHING SOAP', type: 'NonFixedItem' },
      { name: 'TOILET PAPER', type: 'NonFixedItem' },
      { name: 'LIQUID HANDWASH', type: 'NonFixedItem'},
      { name: 'BRUSH', type: 'NonFixedItem' },
      { name: 'PLASTIC', type: 'NonFixedItem' },
      { name: 'DETERGENT', type: 'NonFixedItem' },
      { name: 'DISH SOAP', type: 'NonFixedItem' },
      { name: 'SHAMPOO', type: 'NonFixedItem' },
      { name: 'BATHING SOAP', type: 'NonFixedItem' },
      { name: 'FINEL', type: 'NonFixedItem' },
    ]
    accessories_items = [
      { name: 'CABLE / WIRES', type: 'NonFixedItem' },
      { name: 'DUSTBIN', type: 'NonFixedItem' },
      { name: 'DUST PAN', type: 'NonFixedItem' },
      { name: 'SWEEPING ITEM', type: 'NonFixedItem' },
      { name: 'TOWEL', type: 'NonFixedItem' },
      { name: 'TISSUE PAPER', type: 'NonFixedItem' },
      { name: 'PLATE', type: 'NonFixedItem' },
      { name: 'SPOONS', type: 'NonFixedItem' },
      { name: 'POCHHA', type: 'NonFixedItem' },
      { name: 'MASK', type: 'NonFixedItem' },
      { name: 'WATER BOTTLE', type: 'NonFixedItem' },
      { name: 'GLASS', type: 'NonFixedItem' },
      { name: 'WATER BOTTLE', type: 'NonFixedItem' },
      { name: 'CUP', type: 'NonFixedItem' },
      { name: 'BOWL', type: 'NonFixedItem' },
      { name: 'BUCKETS', type: 'NonFixedItem' },
      { name: 'CLOTHS', type: 'NonFixedItem' },
      { name: 'BATTERY-CHARGABLE', type: 'NonFixedItem' },
      { name: 'BATTERY-NONRECHARGABLE', type: 'NonFixedItem' },
      { name: 'SCREW DRIVER', type: 'NonFixedItem' },
      { name: 'CLAMPERS', type: 'NonFixedItem' },
      { name: 'CUTTERS/KNIFE', type: 'NonFixedItem' }
    ]
    groceries_items = [
      { name: 'SUGAR', type: 'NonFixedItem' },
      { name: 'COFFEE', type: 'NonFixedItem' },
      { name: 'TEA', type: 'NonFixedItem' },
      { name: 'HONEY', type: 'NonFixedItem' },
      { name: 'JUICE', type: 'NonFixedItem' }
    ]
    firstaid_items = [
      { name: 'CETAMOL', type: 'NonFixedItem' },
      { name: 'FLEXON', type: 'NonFixedItem' },
      { name: 'THERMOMETER', type: 'NonFixedItem' },
      { name: 'MOOV / SPRAY', type: 'NonFixedItem' },
      { name: 'BETADINE', type: 'NonFixedItem'},
      { name: 'MOUTHWASH', type: 'NonFixedItem' },
      { name: 'BANDAGE ROLL', type: 'NonFixedItem' },
      { name: 'JEEVAN JAL', type: 'NonFixedItem' },
      { name: 'DIGENE', type: 'NonFixedItem' },
      { name: 'NIMS', type: 'NonFixedItem' },
      { name: 'SINEX', type: 'NonFixedItem' },
      { name: 'COTTON WOOL', type: 'NonFixedItem' },
      { name: 'BANDAGE TAPE', type: 'NonFixedItem' },
      { name: 'HANDPLAST', type: 'NonFixedItem' },
      { name: 'DETTOL LIQUID', type: 'NonFixedItem' },
      { name: 'SANITARY PAD', type: 'NonFixedItem' },
      { name: 'METRONIDAZOLE', type: 'NonFixedItem' },
      { name: 'VAPORUBS', type: 'NonFixedItem' }
    ]
    stationary_items.each { |item| stationaries.items.find_or_create_by item }
    accessories_items.each { |item| accessories.items.find_or_create_by item }
    cleaning_items.each { |item| cleaning.items.find_or_create_by item }
    groceries_items.each { |item| groceries.items.find_or_create_by item }
    firstaid_items.each { |item| firstaid.items.find_or_create_by item }
  end
end
