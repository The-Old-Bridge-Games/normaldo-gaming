import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';

final class SkinsRepositoryTestImpl implements SkinsRepository {
  @override
  Skin getSkinById(String uniqueId) {
    return skinsData.firstWhere(
      (element) => element.uniqueId == uniqueId,
      orElse: () => throw UnexpectedError(),
    );
  }

  @override
  List<Skin> get skinsData => [
        const Skin(
          uniqueId: 'basic',
          name: 'NORMALDO',
          rarity: SkinRarity.classic,
          assets: SkinAssets(
            skinny: 'normaldo/normaldo1.png',
            slim: 'normaldo/normaldo2.png',
            fat: 'normaldo/normaldo3.png',
            superFat: 'normaldo/normaldo4.png',
            skinnyBite: 'normaldo/normaldo1_eat.png',
            slimBite: 'normaldo/normaldo2_eat.png',
            fatBite: 'normaldo/normaldo3_eat.png',
            superFatBite: 'normaldo/normaldo4_eat.png',
            dead: 'normaldo/normaldo1_dead.png',
            mask: 'normaldo/mask.png',
          ),
          resistanceToItems: [],
        ),
        const Skin(
          uniqueId: 'batman',
          name: 'HERO MASK',
          rarity: SkinRarity.rare,
          assets: SkinAssets(
              skinny: 'normaldo/batman/skinny.png',
              slim: 'normaldo/batman/slim.png',
              fat: 'normaldo/batman/fat.png',
              superFat: 'normaldo/batman/super_fat.png',
              skinnyBite: 'normaldo/batman/skinny_bite.png',
              slimBite: 'normaldo/batman/slim_bite.png',
              fatBite: 'normaldo/batman/fat_bite.png',
              superFatBite: 'normaldo/batman/super_fat_bite.png',
              dead: 'normaldo/batman/dead.png',
              mask: 'normaldo/batman/mask.png',
              sfx: {
                'slow': ['batman/BATMAN COCTAIL.mp3'],
                'bite': ['batman/BATMAN EAT.mp3'],
                'hit': ['batman/BATMAN HIT.mp3'],
                'resist': ['batman/BATMAN LAUGHT.mp3'],
                'maxFat': ['batman/max_fat.mp3'],
                'slowMo': ['batman/BATMAN SLOMO.mp3'],
              }),
          resistanceToItems: [
            Items.homeless,
            Items.security,
            Items.policeman,
            Items.handcuffs,
          ],
        ),
        const Skin(
            uniqueId: 'dracula',
            name: 'DRACULA BLOOD',
            rarity: SkinRarity.epic,
            assets: SkinAssets(
                skinny: 'normaldo/dracula/skinny.png',
                slim: 'normaldo/dracula/slim.png',
                fat: 'normaldo/dracula/fat.png',
                superFat: 'normaldo/dracula/super_fat.png',
                skinnyBite: 'normaldo/dracula/skinny_bite.png',
                slimBite: 'normaldo/dracula/slim_bite.png',
                fatBite: 'normaldo/dracula/fat_bite.png',
                superFatBite: 'normaldo/dracula/super_fat_bite.png',
                dead: 'normaldo/dracula/dead.png',
                mask: 'normaldo/dracula/mask.png',
                sfx: {
                  'fatUp': [
                    'dracula/VAMP BUPR.mp3',
                    'dracula/DRACULA BONUS FAT UP.mp3',
                    'dracula/DRACULA BONUS FAT UP2.mp3',
                  ],
                  'slow': [
                    'dracula/VAMP EAT ENJOY.mp3',
                    'dracula/VAMP EAT ENJOY2.mp3',
                  ],
                  'molotov': [
                    'dracula/VAMP EAT ENJOY.mp3',
                    'dracula/VAMP EAT ENJOY2.mp3',
                  ],
                  'bite': [
                    'dracula/VAMP EAT 1.mp3',
                    'dracula/VAMP EAT WSHH.mp3',
                    'dracula/VAMP EAT WSGGGG.mp3',
                  ],
                  'resist': [
                    'dracula/VAMP EAT 1.mp3',
                    'dracula/VAMP EAT WSHH.mp3',
                    'dracula/VAMP EAT WSGGGG.mp3',
                  ],
                  'hit': ['dracula/VAMP HIT.mp3'],
                  'start': ['dracula/VAMP LAUGHT.mp3'],
                  'slowMo': ['dracula/VAMPIRE SLOMO.mp3'],
                  'shredder': ['dracula/VAMP RAW LAUGHT.mp3'],
                  'maxFat': ['dracula/VAMP MAX FAT BLOODY.mp3'],
                }),
            resistanceToItems: [
              Items.cocktail,
              Items.homeless,
              Items.girl,
              Items.policeman,
              Items.security,
              Items.cannibal,
            ],
            uniqueSkill: 'gets some fat from eating human beings'),
        const Skin(
            uniqueId: 'glasses',
            name: 'LUXURY GLASSES',
            rarity: SkinRarity.epic,
            assets: SkinAssets(
              skinny: 'normaldo/glasses/skinny.png',
              slim: 'normaldo/glasses/slim.png',
              fat: 'normaldo/glasses/fat.png',
              superFat: 'normaldo/glasses/super_fat.png',
              skinnyBite: 'normaldo/glasses/skinny_bite.png',
              slimBite: 'normaldo/glasses/slim_bite.png',
              fatBite: 'normaldo/glasses/fat_bite.png',
              superFatBite: 'normaldo/glasses/super_fat_bite.png',
              dead: 'normaldo/glasses/dead.png',
              mask: 'normaldo/glasses/mask.png',
              sfx: {
                'slow': ['glasses/DINK COCTAIL.mp3'],
                'bite': ['glasses/GOLDEN EAT.mp3', 'glasses/GOLDEN EAT 2.mp3'],
                'hit': ['glasses/GOLDEN HIT.mp3'],
                'fatUp': [
                  'glasses/GLASSES   CANT STOP1.mp3',
                  'glasses/GLASSES   CANT STOP2.mp3',
                ],
                'resist': ['glasses/GOLDEN LAUGHT.mp3'],
                'maxFat': ['glasses/GOLDEN MAX FAT.mp3']
              },
            ),
            resistanceToItems: [
              Items.loserTicket,
              Items.handcuffs,
              Items.compass,
            ],
            uniqueSkill: "ain't getting slower after fat up"),
        const Skin(
          uniqueId: 'halloween',
          name: 'PUMPKIN HEAD',
          rarity: SkinRarity.rare,
          assets: SkinAssets(
              skinny: 'normaldo/halloween/skinny.png',
              slim: 'normaldo/halloween/slim.png',
              fat: 'normaldo/halloween/fat.png',
              superFat: 'normaldo/halloween/super_fat.png',
              skinnyBite: 'normaldo/halloween/skinny_bite.png',
              slimBite: 'normaldo/halloween/slim_bite.png',
              fatBite: 'normaldo/halloween/fat_bite.png',
              superFatBite: 'normaldo/halloween/super_fat_bite.png',
              dead: 'normaldo/halloween/dead.png',
              mask: 'normaldo/halloween/mask.png',
              sfx: {
                'bite': [
                  'halloween/HALLOWEN EAT.mp3',
                  'halloween/PUMPKIN EAT.mp3',
                ],
                'maxFat': ['halloween/PUMPKIN MAX FAT.mp3'],
                'slowMo': ['halloween/PUMPKIN SLOMO.mp3'],
                'hit': ['halloween/PUMPKING HIT.mp3'],
                'resist': ['halloween/PUMPKING LAUGHT.mp3'],
              }),
          resistanceToItems: [
            Items.greenPoison,
            Items.cocktail,
            Items.molotov,
            Items.snake,
            Items.homeless,
          ],
        ),
        const Skin(
          uniqueId: 'harry_potter',
          name: "POTTA GLASSES",
          rarity: SkinRarity.legendary,
          assets: SkinAssets(
              skinny: 'normaldo/harry_potter/skinny.png',
              slim: 'normaldo/harry_potter/slim.png',
              fat: 'normaldo/harry_potter/fat.png',
              superFat: 'normaldo/harry_potter/super_fat.png',
              skinnyBite: 'normaldo/harry_potter/skinny_bite.png',
              slimBite: 'normaldo/harry_potter/slim_bite.png',
              fatBite: 'normaldo/harry_potter/fat_bite.png',
              superFatBite: 'normaldo/harry_potter/super_fat_bite.png',
              dead: 'normaldo/harry_potter/dead.png',
              mask: 'normaldo/harry_potter/mask.png',
              sfx: {
                'hit': ['harry_potter/POTTER HIT.mp3'],
                'bomb': ['harry_potter/POTTER BOMB.mp3'],
                'bite': ['harry_potter/POTTER EAT.mp3'],
                'dollar': ['harry_potter/POTTER enjoy money.mp3'],
                'shredder': ['harry_potter/POTTER GREAT.mp3'],
                'resist': ['harry_potter/POTTER LAUGHT.mp3'],
                'start': ['harry_potter/POTTER NORMALDO SAYNG.mp3'],
                'slowMo': ['harry_potter/POTTER SLOMO MAHOVIK.mp3'],
                'maxFat': ['harry_potter/POTTER MAX FAT.mp3'],
                'unique': [
                  'harry_potter/POTTER VANISH1.mp3',
                  'harry_potter/POTTER VANISH2.mp3',
                  'harry_potter/POTTER VANISH3.mp3',
                ],
              }),
          resistanceToItems: [
            Items.greenPoison,
            Items.snake,
            Items.cocktail,
            Items.letterBottle,
            Items.umbrella,
            Items.angryDog,
            Items.handcuffs,
            Items.bird,
            Items.cone,
            Items.loserTicket,
            Items.compass,
          ],
          uniqueSkill: 'vanishing trick+',
        ),
        const Skin(
          uniqueId: 'new_year',
          name: "NEW YEAR HAT",
          rarity: SkinRarity.rare,
          assets: SkinAssets(
              skinny: 'normaldo/new_year/skinny.png',
              slim: 'normaldo/new_year/slim.png',
              fat: 'normaldo/new_year/fat.png',
              superFat: 'normaldo/new_year/super_fat.png',
              skinnyBite: 'normaldo/new_year/skinny_bite.png',
              slimBite: 'normaldo/new_year/slim_bite.png',
              fatBite: 'normaldo/new_year/fat_bite.png',
              superFatBite: 'normaldo/new_year/super_fat_bite.png',
              dead: 'normaldo/new_year/dead.png',
              mask: 'normaldo/new_year/mask.png',
              sfx: {
                'slowMo': ['new_year/SANTA Bells Christmas SLOMO.mp3'],
                'bite': [
                  'new_year/SANTA EAT 1.mp3',
                  'new_year/SANTA EAT 2.mp3'
                ],
                'hit': ['new_year/SANTA HIT.mp3'],
                'maxFat': ['new_year/SANTA MAX FAT.mp3'],
                'shredder': ['new_year/SANTA SOUND HOHOHO.mp3'],
                'moneyBag': ['new_year/SANTA TAKE MONEY OR COCTAIL.mp3'],
              }),
          resistanceToItems: [
            Items.homeless,
            Items.security,
            Items.policeman,
            Items.greenPoison,
            Items.cocktail,
            Items.molotov,
            Items.handcuffs,
            Items.note,
            Items.note2,
          ],
          uniqueSkill: 'causes cozy snowfall',
        ),
        const Skin(
            uniqueId: 'pirate',
            name: "PIRATE HAT",
            rarity: SkinRarity.legendary,
            assets: SkinAssets(
                skinny: 'normaldo/pirate/skinny.png',
                slim: 'normaldo/pirate/slim.png',
                fat: 'normaldo/pirate/fat.png',
                superFat: 'normaldo/pirate/super_fat.png',
                skinnyBite: 'normaldo/pirate/skinny_bite.png',
                slimBite: 'normaldo/pirate/slim_bite.png',
                fatBite: 'normaldo/pirate/fat_bite.png',
                superFatBite: 'normaldo/pirate/super_fat_bite.png',
                dead: 'normaldo/pirate/dead.png',
                mask: 'normaldo/pirate/mask.png',
                sfx: {
                  'bite': [
                    'pirate/PIRATE  EAT 2.mp3',
                    'pirate/PIRATE EAT1.mp3'
                  ],
                  'slowMo': ['pirate/PIRATE BRIIZZ SLOMO.mp3'],
                  'shredder': ['pirate/PIRATE HEHEY.mp3'],
                  'hit': ['pirate/PIRATE HITwav.mp3'],
                  'resist': [
                    'pirate/PIRATE PIRAT COCTAIL ENJOING.mp3',
                    'pirate/PIRATE LAUGHT.mp3',
                    'pirate/PIRATE LAUGHTLONG.mp3',
                  ],
                  'maxFat': ['pirate/PIRATE MAXFAT.mp3'],
                  'unique': [
                    'pirate/PIRAT X 3 BONUS 1.mp3',
                    'pirate/PIRAT X 3 BONUS 2.mp3',
                  ],
                }),
            resistanceToItems: [
              Items.homeless,
              Items.cocktail,
              Items.greenPoison,
              Items.molotov,
              Items.security,
              Items.policeman,
              Items.handcuffs,
              Items.shipPart,
              Items.loserTicket,
              Items.compass,
              Items.gun,
            ],
            uniqueSkill: 'accidentally takes x3 dollars'),
        const Skin(
          uniqueId: 'spider-man',
          name: "THE HUMAN SPIDER \nMASK",
          rarity: SkinRarity.legendary,
          assets: SkinAssets(
              skinny: 'normaldo/spider_man/skinny.png',
              slim: 'normaldo/spider_man/slim.png',
              fat: 'normaldo/spider_man/fat.png',
              superFat: 'normaldo/spider_man/super_fat.png',
              skinnyBite: 'normaldo/spider_man/skinny_bite.png',
              slimBite: 'normaldo/spider_man/slim_bite.png',
              fatBite: 'normaldo/spider_man/fat_bite.png',
              superFatBite: 'normaldo/spider_man/super_fat_bite.png',
              dead: 'normaldo/spider_man/dead.png',
              mask: 'normaldo/spider_man/mask.png',
              sfx: {
                'bite': [
                  'spider_man/EAT WEB.mp3',
                  'spider_man/SPIDER WEB.mp3',
                ],
                'fatUp': ['spider_man/SPIDER BURP.mp3'],
                'hit': [
                  'spider_man/SPIDER HIT.mp3',
                  'spider_man/SPIDER HIT 2.mp3',
                ],
                'slowMo': ['spider_man/SPIDER SLOMO.mp3'],
                'slow': [
                  'spider_man/SPIDER SIP.mp3',
                  'spider_man/SPIDER SIP  COCTAIL.mp3',
                ],
                'resist': ['spider_man/SPIDER LAUGHT.mp3'],
                'unique': [
                  'spider_man/SPIDER RESIST1.mp3',
                  'spider_man/SPIDER RESIST2.mp3',
                ]
              }),
          resistanceToItems: [
            Items.homeless,
            Items.trashBin,
            Items.security,
            Items.policeman,
            Items.cone,
            Items.stone,
            Items.roadSign,
            Items.umbrella,
            Items.handcuffs,
            Items.gun,
          ],
          uniqueSkill: 'spidey sense',
        ),
        const Skin(
          uniqueId: 'viking',
          name: "VIKING HELMET",
          rarity: SkinRarity.common,
          assets: SkinAssets(
              skinny: 'normaldo/viking/skinny.png',
              slim: 'normaldo/viking/slim.png',
              fat: 'normaldo/viking/fat.png',
              superFat: 'normaldo/viking/super_fat.png',
              skinnyBite: 'normaldo/viking/skinny_bite.png',
              slimBite: 'normaldo/viking/slim_bite.png',
              fatBite: 'normaldo/viking/fat_bite.png',
              superFatBite: 'normaldo/viking/super_fat_bite.png',
              dead: 'normaldo/viking/dead.png',
              mask: 'normaldo/viking/mask.png',
              sfx: {
                'maxFat': ['viking/MAX FAT.mp3'],
                'slowMo': ['viking/VIKING  SLOMO.mp3'],
                'bite': [
                  'viking/VIKING EAT 2.mp3',
                  'viking/VIKING EAT.mp3',
                ],
                'resist': ['viking/VIKING LAUGHT.mp3'],
                'hit': ['viking/VIKINGS  HIT.mp3'],
                'slow': ['viking/VIKINGS COCTAIL.mp3'],
              }),
          resistanceToItems: [
            Items.trashBin,
            Items.cone,
            Items.roadSign,
          ],
        ),
        const Skin(
          uniqueId: 'wizard',
          name: "MAGIC WAND",
          rarity: SkinRarity.epic,
          assets: SkinAssets(
              skinny: 'normaldo/wizard/skinny.png',
              slim: 'normaldo/wizard/slim.png',
              fat: 'normaldo/wizard/fat.png',
              superFat: 'normaldo/wizard/super_fat.png',
              skinnyBite: 'normaldo/wizard/skinny_bite.png',
              slimBite: 'normaldo/wizard/slim_bite.png',
              fatBite: 'normaldo/wizard/fat_bite.png',
              superFatBite: 'normaldo/wizard/super_fat_bite.png',
              dead: 'normaldo/wizard/dead.png',
              mask: 'normaldo/wizard/mask.png',
              sfx: {
                'fatUp': ['wizard/WIZARD BURP.mp3'],
                'resist': [
                  'wizard/WIZARD COCTAIL ENJOY.mp3',
                  'wizard/WIZARD COCTAIL.mp3',
                  'wizard/WIZARD SIP SOME.mp3',
                ],
                'bite': [
                  'wizard/WIZARD eat.mp3',
                  'wizard/WIZARD EAT2.mp3',
                ],
                'hit': ['wizard/WIZARD HIT.mp3'],
                'shredder': ['wizard/WIZARD LAUGHT DOGE.mp3'],
                'slowMo': ['wizard/WIZARD SLOMO.mp3'],
                'unique': [
                  'wizard/WIZARD VANISH RESIST1.mp3',
                  'wizard/WIZARD VANISH RESIST2.mp3',
                ],
              }),
          resistanceToItems: [
            Items.cocktail,
            Items.policeman,
            Items.homeless,
            Items.security,
            Items.greenPoison,
            Items.loserTicket,
            Items.handcuffs,
            Items.gun,
          ],
          uniqueSkill: 'vanishing trick',
        ),
        const Skin(
          uniqueId: 'tyson',
          name: "TYSON",
          rarity: SkinRarity.common,
          assets: SkinAssets(
              skinny: 'normaldo/tyson/1-1.png',
              slim: 'normaldo/tyson/2-1.png',
              fat: 'normaldo/tyson/3-1.png',
              superFat: 'normaldo/tyson/4-1.png',
              skinnyBite: 'normaldo/tyson/1-2.png',
              slimBite: 'normaldo/tyson/2-2.png',
              fatBite: 'normaldo/tyson/3-2.png',
              superFatBite: 'normaldo/tyson/4-2.png',
              dead: 'normaldo/tyson/deadmode.png',
              mask: 'normaldo/tyson/LOGO.png',
              sfx: {
                'fatUp': ['tyson/TYSON TALKING.mp3'],
                'resist': [
                  'tyson/TYSON EVAID Dub.mp3',
                  'tyson/TYSON EVAID LEFT RIGHT.mp3',
                ],
                'bite': [
                  'tyson/TYSON  EAT Dub.mp3',
                  'tyson/TYSON  EAT.mp3',
                ],
                'hit': ['tyson/TYSON  hit.mp3'],
                'slowMo': ['tyson/TYSON  SLOMO.mp3'],
              }),
          resistanceToItems: [
            Items.punch,
          ],
        ),
        const Skin(
          uniqueId: 'joker',
          name: "JOKER",
          rarity: SkinRarity.legendary,
          assets: SkinAssets(
              skinny: 'normaldo/joker/1-1.png',
              slim: 'normaldo/joker/2-1.png',
              fat: 'normaldo/joker/3-1.png',
              superFat: 'normaldo/joker/4-1.png',
              skinnyBite: 'normaldo/joker/1-2.png',
              slimBite: 'normaldo/joker/2-2.png',
              fatBite: 'normaldo/joker/3-2.png',
              superFatBite: 'normaldo/joker/4-2.png',
              dead: 'normaldo/joker/deadmode.png',
              mask: 'normaldo/joker/logo.png',
              sfx: {
                'fatUp': ['joker/JOCKER BURP.mp3'],
                // 'resist': [
                //   'tyson/TYSON EVAID Dub.mp3',
                //   'tyson/TYSON EVAID LEFT RIGHT.mp3',
                // ],
                'bite': [
                  'joker/JOCKER EAT 1.mp3',
                  'joker/JOCKER EAT.mp3',
                ],
                'hit': ['joker/JOCKER HIT.mp3'],
                'slowMo': ['joker/JOCKER SLOMO.mp3'],
                'start': ['joker/JOCKER LAUGHT.mp3']
              }),
          resistanceToItems: [
            Items.loserTicket,
            Items.policeman,
            Items.handcuffs,
            Items.spadesCard,
            Items.casinoChip,
            Items.security,
          ],
        ),
        const Skin(
          uniqueId: 'kuss',
          name: "KUSS",
          rarity: SkinRarity.rare,
          assets: SkinAssets(
              skinny: 'normaldo/kuss/1-1.png',
              slim: 'normaldo/kuss/2-1.png',
              fat: 'normaldo/kuss/3-1.png',
              superFat: 'normaldo/kuss/4-1.png',
              skinnyBite: 'normaldo/kuss/1-2.png',
              slimBite: 'normaldo/kuss/2-2.png',
              fatBite: 'normaldo/kuss/3-2.png',
              superFatBite: 'normaldo/kuss/4-2.png',
              dead: 'normaldo/kuss/deadmode.png',
              mask: 'normaldo/kuss/logo.png',
              sfx: {
                'fatUp': ['kuss/KUSS BURP.mp3'],
                'resist': [
                  'kuss/KUSS TALKING.mp3',
                ],
                'bite': [
                  'kuss/KUSS EAT Dub.mp3',
                  'kuss/KUSS EAT.mp3',
                ],
                'hit': [
                  'kuss/KUSS HIT Dub.mp3',
                  'kuss/KUSS HIT.mp3',
                ],
                'slowMo': ['kuss/KUSS SLOMO.mp3'],
                'start': ['kuss/KUSS LAUGHT.mp3']
              }),
          resistanceToItems: [
            Items.bananaPeel,
            Items.beer,
            Items.cocktail,
            Items.greenPoison,
          ],
        ),
      ]..sort((a, b) => a.rarity.index - b.rarity.index);
}
