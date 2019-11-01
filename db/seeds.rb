# frozen_string_literal: true

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

categories = [
  { id: 1, name: 'OFFICE EQUIPMENT', depreciation_rate: '25', type: 'FixedItemCategory' },
  { id: 2, name: 'FURNITURE & FIXTURES', depreciation_rate: '25', type: 'FixedItemCategory' },
  { id: 3, name: 'LAND & DEVELOPMENTS', depreciation_rate: '5', type: 'FixedItemCategory' },
  { id: 4, name: 'STATIONARIES', type: 'NonFixedItemCategory' },
  { id: 5, name: 'CLEANING & SANITATION', type: 'NonFixedItemCategory' },
  { id: 6, name: 'ACCESSORIES', type: 'NonFixedItemCategory' },
  { id: 7, name: 'GROCERIES', type: 'NonFixedItemCategory' },
  { id: 8, name: 'FIRST AID', type: 'NonFixedItemCategory' }
]
categories.each { |category| Category.create category }

fixed_items = [
  { name: 'LAPTOP', category_id: 1 },
  { name: 'IMAC', category_id: 1 },
  { name: 'MACBOOK', category_id: 1 },
  { name: 'DESKTOP COMPUTER', category_id: 1 },
  { name: 'MONITOR', category_id: 1 },
  { name: 'NUC', category_id: 1 },
  { name: 'TV', category_id: 1 },
  { name: 'KEYBOARD', category_id: 1 },
  { name: 'MOUSE', category_id: 1 },
  { name: 'EXTENSION CORD', category_id: 1 },
  { name: 'PROJECTOR', category_id: 1 },
  { name: 'SPEAKER', category_id: 1 },
  { name: 'MICROPHONE', category_id: 1 },
  { name: 'ELECTRIC STAND FAN', category_id: 1 },
  { name: 'WATER COOLER', category_id: 1 },
  { name: 'WALL HEATER', category_id: 1 },
  { name: 'STAND HEATER', category_id: 1 },
  { name: 'MOBILE', category_id: 1 },
  { name: 'GAS CYLINDER', category_id: 1 },
  { name: 'GAS HEATER', category_id: 1 },
  { name: 'CHROMECAST', category_id: 1 },
  { name: 'WIRELESS SPEAKER', category_id: 1 },
  { name: 'PRINTER', category_id: 1 },
  { name: 'MONITOR STAND', category_id: 1 },
  { name: 'CLOCK', category_id: 1 },
  { name: 'MOUSE PAD', category_id: 1 },
  { name: 'PENDRIVE', category_id: 1 },
  { name: 'SD CARD', category_id: 1 },
  { name: 'CHARGER', category_id: 1 },
  { name: 'LIQUID BATTERY', category_id: 1 },
  { name: 'VACUUM CLEANER', category_id: 1 },

  { name: 'TABLE', category_id: 2 }, { name: 'CHAIR', category_id: 2 },
  { name: 'TOOLS', category_id: 2 }, { name: 'CUPBOARD', category_id: 2 },
  { name: 'FILE RACK', category_id: 2 }, { name: 'OFFICE PARTITION', category_id: 2 },
  { name: 'BOX', category_id: 2 },

  { name: 'LAND', category_id: 3 }, { name: 'DEVELOPMENT WORKS', category_id: 3 }
]

fixed_items.each { |fixed_item| FixedItem.create fixed_item }

non_fixed_items = [
  { name: 'SPIRAL DIARY', category_id: 4 },
  { name: 'SPIRAL MINI NOTEBOOK', category_id: 4 },
  { name: 'COPY', category_id: 4 },
  { name: 'DIARY', category_id: 4 },
  { name: 'BALL PEN', category_id: 4 },
  { name: 'PILOT PEN', category_id: 4 },
  { name: 'PENCIL', category_id: 4 },
  { name: 'ERASER', category_id: 4 },
  { name: 'SHARPNER', category_id: 4 },
  { name: 'PHOTOCOPY PAPER', category_id: 4 },
  { name: 'SIGN PEN / COLOR PEN', category_id: 4 },
  { name: 'PERMANENT MARKER', category_id: 4 },
  { name: 'BOARD MARKER', category_id: 4 },
  { name: 'STICKY NOTES', category_id: 4 },
  { name: 'GLUE STICK', category_id: 4 },
  { name: 'STAPLER', category_id: 4 },
  { name: 'STAPLE / PIN', category_id: 4 },
  { name: 'NEPALI FILE', category_id: 4 },
  { name: 'INDEX / VERTEX FILE', category_id: 4 },
  { name: 'CARBON PAPER', category_id: 4 },
  { name: 'STICKY TAPES', category_id: 4 },
  { name: 'ENVELOPE', category_id: 4 },
  { name: 'LETTER PAD/HEAD', category_id: 4 },
  { name: 'MASKING TAPE', category_id: 4 },
  { name: 'META CARDS', category_id: 4 },
  { name: 'COLOUR PAPER', category_id: 4 },
  { name: 'PUNCHING MACHINE', category_id: 4 },
  { name: 'CALCULATOR', category_id: 4 },
  { name: 'PAPER CUTTER', category_id: 4 },
  { name: 'SCALE', category_id: 4 },
  { name: 'CLIP / PIN', category_id: 4 },
  { name: 'INK', category_id: 4 },
  { name: 'TABLE FILE RACK', category_id: 4 },
  { name: 'TEXTLINER / HIGHLIGHTER', category_id: 4 },
  { name: 'SCISSORS', category_id: 4 },
  { name: 'WRITING BOARD / EXAM BOARD', category_id: 4 },
  { name: 'CLEAR BAG', category_id: 4 },
  { name: 'PENDRIVE', category_id: 4 },
  { name: 'DUSTER', category_id: 4 },
  { name: 'STAMP PAD', category_id: 4 },
  { name: 'CARTAGE & TONER', category_id: 4 },
  { name: 'CORRECTION PEN', category_id: 4 },
  { name: 'PAPER CLIP', category_id: 4 },
  { name: 'BOOKS', category_id: 4 },

  { name: 'BATHROOM FRESHNER', category_id: 5 },
  { name: 'DETTOL SOAP', category_id: 5 },
  { name: 'TOILET CLEANER / HARPIC', category_id: 5 },
  { name: 'HOUSEHOLD CLEANER / COLIN', category_id: 5 },
  { name: 'TOILET CLEANER', category_id: 5 },
  { name: 'WASHING SOAP', category_id: 5 },
  { name: 'TOILET PAPER', category_id: 5 },
  { name: 'LIQUID HANDWASH', category_id: 5 },
  { name: 'BRUSH', category_id: 5 },
  { name: 'PLASTIC', category_id: 5 },
  { name: 'DETERGENT', category_id: 5 },
  { name: 'DISH SOAP', category_id: 5 },
  { name: 'SHAMPOO', category_id: 5 },
  { name: 'BATHING SOAP', category_id: 5 },
  { name: 'FINEL', category_id: 5 },

  { name: 'CABLE / WIRES', category_id: 6 },
  { name: 'DUSTBIN', category_id: 6 },
  { name: 'DUST PAN', category_id: 6 },
  { name: 'SWEEPING ITEM', category_id: 6 },
  { name: 'TOWEL', category_id: 6 },
  { name: 'TISSUE PAPER', category_id: 6 },
  { name: 'PLATE', category_id: 6 },
  { name: 'SPOONS', category_id: 6 },
  { name: 'POCHHA', category_id: 6 },
  { name: 'MASK', category_id: 6 },
  { name: 'WATER BOTTLE', category_id: 6 },
  { name: 'GLASS', category_id: 6 },
  { name: 'WATER BOTTLE', category_id: 6 },
  { name: 'CUP', category_id: 6 },
  { name: 'BOWL', category_id: 6 },
  { name: 'BUCKETS', category_id: 6 },
  { name: 'CLOTHS', category_id: 6 },
  { name: 'BATTERY-CHARGABLE', category_id: 6 },
  { name: 'BATTERY-NONRECHARGABLE', category_id: 6 },
  { name: 'SCREW DRIVER', category_id: 6 },
  { name: 'CLAMPERS', category_id: 6 },
  { name: 'CUTTERS/KNIFE', category_id: 6 },

  { name: 'SUGAR', category_id: 7 },
  { name: 'COFFEE', category_id: 7 },
  { name: 'TEA', category_id: 7 },
  { name: 'HONEY', category_id: 7 },
  { name: 'JUICE', category_id: 7 },

  { name: 'CETAMOL', category_id: 8 },
  { name: 'FLEXON', category_id: 8 },
  { name: 'THERMOMETER', category_id: 8 },
  { name: 'MOOV / SPRAY', category_id: 8 },
  { name: 'BETADINE', category_id: 8 },
  { name: 'MOUTHWASH', category_id: 8 },
  { name: 'BANDAGE ROLL', category_id: 8 },
  { name: 'JEEVAN JAL', category_id: 8 },
  { name: 'DIGENE', category_id: 8 },
  { name: 'NIMS', category_id: 8 },
  { name: 'SINEX', category_id: 8 },
  { name: 'COTTON WOOL', category_id: 8 },
  { name: 'BANDAGE TAPE', category_id: 8 },
  { name: 'HANDPLAST', category_id: 8 },
  { name: 'DETTOL LIQUID', category_id: 8 },
  { name: 'SANITARY PAD', category_id: 8 },
  { name: 'METRONIDAZOLE', category_id: 8 },
  { name: 'VAPORUBS', category_id: 8 }
]
non_fixed_items.each { |non_fixed_item| FixedItem.create non_fixed_item }
