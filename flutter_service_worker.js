'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "a87668cd77924ccc8dd036ffe811cf69",
".git/config": "f310076a0952877049f067fdebc47c37",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "4faa354334ebfbea0ff0aaa18de9e2b4",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "3c5989301dd4b949dfa1f43738a22819",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/update.sample": "7bf1fcc5f411e5ad68c59b68661660ed",
".git/index": "cb1576e45e8748424589f531d35a82a6",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "69eb21d54046d2c458bc7a28624ce285",
".git/logs/refs/heads/master": "69eb21d54046d2c458bc7a28624ce285",
".git/logs/refs/heads/v2": "ac58a74eb76760efe69ff15cf9c6becf",
".git/logs/refs/remotes/origin/HEAD": "48641ae72031e4b4a14d340e95932865",
".git/logs/refs/remotes/origin/master": "e3bd02041ba6026dac1c638996ef34a6",
".git/objects/07/2d7c098201e41d19249b8c9366c38be5d3a43e": "8ffff375df5a870ef76e66301c8d9830",
".git/objects/0d/d8a3ff8d13e78e32a42af8cf5a2fe8f8252c94": "7ff7a74da276268f8a9bfbed7545a39d",
".git/objects/0f/c344c7e8b9e32ea1ad91f30ded22556352d7bf": "a8a30f28869f7378465338066f34d80d",
".git/objects/18/eb401097242a0ec205d5f8abd29a4c5e09c5a3": "4e08af90d04a082aab5eee741258a1dc",
".git/objects/1a/b647493dc42b5380bebf827a079aea2ee58a18": "02d7f6821b7e85eecae9ee4d8b3f0edb",
".git/objects/1d/384f3748038966a5c7316223edf120dd5894dd": "a8d542276aa823dfefb8d26439e1077a",
".git/objects/1d/5159f855db8a0924732cdc234206c10d6e62ae": "5450619aa01f1a9f1306aa6c71f7994a",
".git/objects/1d/b6acaa770b3c5eb8749bad97e0b3ae9862a931": "950f6f725ee4c9f9251c6dfed72491d1",
".git/objects/1e/62790c489721a57e8a933f782a9b9b94086d8c": "8a16f36d5a73c93b1e1d8158b3f5b24e",
".git/objects/1e/bd7b7b7c1491eb397d4d873ce834f51b84b3ab": "ce2966bb6ca0facb9c44d834035da84c",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/20/cb2f80169bf29d673844d2bb6a73bc04f3bfb8": "b807949265987310dc442dc3f9f492a2",
".git/objects/22/e6374305f01e397a18c9659fc7a43dcbdd23ac": "f39ca557f39c3a7c06e186697737dfd1",
".git/objects/25/27a287a6bd07e19f0c691ac6df77078df2e676": "c59f241c6bb14edb5df1f4e26cded123",
".git/objects/25/8b3eee70f98b2ece403869d9fe41ff8d32b7e1": "05e38b9242f2ece7b4208c191bc7b258",
".git/objects/3b/8622f67bffda70fc2d7f6ff2f2ad6f3078fd08": "731b64a59569a859ccc7057722b737a4",
".git/objects/44/1d3baab4f3bfc1ce251942e420988fac12a8f4": "ac3a2ba50af07d40313ad29d8023a3b1",
".git/objects/47/cad8ac398d5ee31b6bbbd3eb5f4fa01b47a57b": "6b48ee41afdb4aecc4fe8cc3a1214ebe",
".git/objects/49/1191ac105362bd99bf34a6c3c3cd84cc0f9607": "91e7146cf3dee72a6301ea7940d311d4",
".git/objects/49/adebdb511c8c293b28db3f6792e5bac28cdc32": "ba6a3971e7f06834fd6ec3844372ce17",
".git/objects/4b/733ab01f8d7753c1a31cdcfd98d7341e6655dc": "6c66fab5a86526e0e6819964fc558678",
".git/objects/4b/825dc642cb6eb9a060e54bf8d69288fbee4904": "75589287973d2772c2fc69d664e10822",
".git/objects/52/cfb77a424101413b81e246b965151f443a0e85": "453827b9337fef0116c048dee437d21d",
".git/objects/58/356635d1dc89f2ed71c73cf27d5eaf97d956cd": "f61f92e39b9805320d2895056208c1b7",
".git/objects/58/3580de8467404e5e2272705ea985d84fc6bc35": "498920e51f5df41f2efe8ffbe6704adf",
".git/objects/58/b007afeab6938f7283db26299ce2de9475d842": "6c6cbea527763bb3cdff2cecfee91721",
".git/objects/5a/c6a48c7728bd93b5e3e6b3a14ce0dc4a26a823": "849f2fdb74b9ed8dc921675c69522700",
".git/objects/62/a01d6826913d9efa140d2e9f4bc0f13918e607": "44ba2af6a4f05cb190463143170ae010",
".git/objects/62/c89ee094658c7a9465824fdb42793a64ea557b": "133cd5da638f245b079d9e9cdc29ae38",
".git/objects/63/ca00ff9e688702e8dd9981c77c7eecec811f2f": "b759b30c65b2d9722aae613462307aec",
".git/objects/64/0a206fd9ef0b2517ce411e4df633f9defd46b1": "aee97a594e89eaad26825cee22b32847",
".git/objects/6f/2f3754eccf0edc494fff5d15bb67f6a044e817": "56d64fb0b62584cd35821b3849d9fdda",
".git/objects/6f/b7bc0fcc214e368f88bf66d851bb69a618172b": "961ebcc0c43ad7e27895e0ef696be984",
".git/objects/70/1c70ef1781db909c1df1d5e89eee90acd3d9c9": "e57dd766c468808f467f69a63feafa22",
".git/objects/70/beb28e3b0751ffc5ddb8e62304ffef8c5c1737": "52cf00fb919de353f00afb05381d9c81",
".git/objects/71/1381263247b2312814adebe689552fac7a57c1": "1ab47c89c77bf761757bdb36ef342638",
".git/objects/71/3f932c591e8f661aa4a8e54c32c196262fd574": "66c6c54fbdf71902cb7321617d5fa33c",
".git/objects/73/8852d13c1864f462638da425d76ec7778b8cfc": "0ed7d1627a60fde44dcea689b98e6830",
".git/objects/77/fcbea30f3d596160fe35cdb939e3dce0b88ef1": "406c2701aa986851737bc5b2e10464da",
".git/objects/82/1eace41e6b079c013bf4f05aa3b122ba7a38cb": "d9b74bc6950f317edb8592f24443fc81",
".git/objects/83/a9877f36b1e9786ba70d26d698fa67a96c4877": "2df6337f40b7138ec112ff60d390befe",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/86/a1f8492ffd49c1b6cb99f0415c1d3cdbb4844c": "803b7ba44b5b9042e03d0d1f751ef26d",
".git/objects/87/e2dbf2636c4be6bb26489957998dd98417732c": "f73d12cc0c8a1b58f81f2d88ee7284a5",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8e/7f4b338840099949781ab85496d7a67fae46f1": "7f2803c236e9e7d95ef6ed16a3a2bd13",
".git/objects/94/f7d06e926d627b554eb130e3c3522a941d670a": "77a772baf4c39f0a3a9e45f3e4b285bb",
".git/objects/96/1fb01aa6554c094e3bee646d803b8c657ac840": "b5e535cd9d45590b98d2e0f53a8809f6",
".git/objects/98/0ba3f7963a12f74efffa1c865947c67614d7e7": "494fe7ffcc7fd8a65fb6ff7370c4979c",
".git/objects/98/7975fc0334775cec59902798235f2b79d69c9c": "b41605d09273d86ea29b55eb140610fe",
".git/objects/9f/e2d6f96f5effa6896803aabaf1fb42ed78df1f": "d8d40fef6c3974aa77caa03a16671320",
".git/objects/a0/2339b90266b14c5c059dfb7adcaa42b4d31391": "da61dad82f3f78744292515aa4580f18",
".git/objects/a0/31f4bf4a45e62d3e53f430d532167d84efd6e0": "d0325dbc86c49992d829e7b9e99a7172",
".git/objects/a0/4d369c15584731e93746c1a7bb3ae60631fc83": "f7ce07a4cfd049f0b84a9d1ee9006e1c",
".git/objects/a4/49b1a71fbd3b41e0a1077bbf6b9674f8e26341": "e25a0949803339ae10c61bdb88d2e1dc",
".git/objects/ab/ff7f05c711337db71b2e696c6b2051924e0aff": "00b39227c5f92a25065116eda0e48af1",
".git/objects/ad/b4e96119c83ad45906a3cc658fc5bedeefdaa6": "f31b85dd89580976e03fe418d242e0dd",
".git/objects/ad/cbbda879a44c08ad971cb891789c0a9b5f1f2b": "bc8c4ea91f9819093d5fdd325227b02e",
".git/objects/ae/37803d1933c3979fd1b939ff61cc667b0b70dc": "f5c08c98e82ebd9034dbd78b64a292fa",
".git/objects/b3/ebbd38f666d4ffa1a394c5de15582f9d7ca6c0": "23010709b2d5951ca2b3be3dd49f09df",
".git/objects/b3/ec1c6226235fd5d7d27e797300b03b680219b8": "c1302cba4e35f618268debe9f94796ad",
".git/objects/b4/40bf075794fb249edb7657fd5be50f72700409": "438961568824080670cf0d9dcb74b827",
".git/objects/b6/847af84668f859e670bc343cb1767c5f9fb9a1": "2b1c613b00e1262af4bd1c864593130b",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/bd/a3bae6fd6aa2ab90de16103675dddba9c8f0ab": "b4317f08192aa4e6492dabf258a0ff4e",
".git/objects/c1/bcbfaa093da6a923aa1c9e9432b8c458568655": "e5ec0900805dd2b0d664d4f854c30d8f",
".git/objects/c2/0ed02fa06eacf12f5ea9648cfc57b01852c8d5": "d1ac4a745336527b2ae884177eca05c6",
".git/objects/c2/ac5271cc8c6e5efa25bd47afc0adadb2d0ec3a": "1f42f457419d2f0cb704b3f1e5768778",
".git/objects/c2/d834be28507165c134ead0c40ad823cd31b6af": "a8a2a844b7c3087187437e90ddbfc96f",
".git/objects/c3/bdb59b5250c939f15e6ea7e62e3e149ca11024": "85bfe7a3e2f7920e2fe6c8973e894b73",
".git/objects/c6/6f2332a7d758c82b26b54b575a7c029c9d7cc8": "e8b32176a3e7cca303f7cdd584f92d56",
".git/objects/c9/bf8af1b92c723b589cc9afadff1013fa0a0213": "632f11e7fee6909d99ecfd9eeab30973",
".git/objects/ca/4df9c0d4e27a6889800791833c0f40fa31e738": "87e1b3a00fab4baf0f8b7c8bb3f0ede3",
".git/objects/cf/3a49b9fa64bfd07ab704577190aec74a44c03d": "056e01ef4ae81b64385fd95da6d5815a",
".git/objects/cf/6d83222ea60b3f10608f3ff76c1ad2260fc044": "7c65d126fa78d5c45c97951888064227",
".git/objects/d1/098e7588881061719e47766c43f49be0c3e38e": "f17e6af17b09b0874aa518914cfe9d8c",
".git/objects/d3/9984d8069da58ab072a11546566e138ca7cdca": "aa6b1a801e4d3008eed47fb616bac907",
".git/objects/d3/a7d98160239fe34f2def64a0a8f65885375158": "bdbbf68878b8fd9fed61d10a9a26e773",
".git/objects/d3/efa7fd80d9d345a1ad0aaa2e690c38f65f4d4e": "610858a6464fa97567f7cce3b11d9508",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/db/810cd6774fa14d069cd0bd9c06fb9a7d639ca0": "b192550ce485442186a534bc4d75d9dc",
".git/objects/e4/8d8fe1bcfc2b4f85be12156fe003f23917dabc": "84b353fd870940a026af86986dcbfa93",
".git/objects/e4/bf3ad640d6e0f4d80766b6d7972de641157079": "b51fb8f7fc5f85a847e0f99a4ab99c04",
".git/objects/e7/3b5df783a1bd3d87e225eeb7e44cc561115ef9": "9e94fd53551c77ffd6a7ddd32030b210",
".git/objects/e7/5e920f175da53dd6f04d858636baa25dc702f4": "0fd694d0b7477cee41611e70d0cd6732",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ec/ee7878b5b9d881cfd8904a3bfa7661745559f6": "c1a1c334190020c048d1afee76c0f104",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f4/7daeea4ab7f121c60e3a80670d7a9ec6020969": "d2669a5a34ce241ca9f0fcee5fc31a47",
".git/objects/f6/0154dc622c980f364331f323d04cbd2daf9ce7": "38edf90cf12d856db8abb57cc55b91c7",
".git/objects/fb/149277c05752b604e4ace39a4b40dc47e6f2c2": "43395ce93800277bcc2a3ec5025c8dea",
".git/objects/fb/2aed468c77aa03c4ed4139a2aa63185e3c5d47": "bc59c0bbf79ef8d6f8edde5269fc7b9c",
".git/objects/fb/4c02fd3b561ecc7365e420583356426d541b29": "e1e45e2b36a0cb1d5f917dec370aab0e",
".git/objects/fb/f57e78a43b8ff1af992dfcab7551f2c98b0007": "e6138d2209987f9ac4962fabe1f9fe36",
".git/objects/fc/5cdb790622738c39c1ac07ea930b5d5645bb38": "18c8096ca681f9c595bd9db7bf75f399",
".git/ORIG_HEAD": "7925cb0c4fb0d50ce526d0ed25e760d9",
".git/packed-refs": "bffe64ff59318c58155bed6ff82b3b2b",
".git/refs/heads/master": "cd1c7bdff71191dafbf75e818e9c7a7f",
".git/refs/heads/v2": "7925cb0c4fb0d50ce526d0ed25e760d9",
".git/refs/remotes/origin/HEAD": "73a00957034783b7b5c8294c54cd3e12",
".git/refs/remotes/origin/master": "cd1c7bdff71191dafbf75e818e9c7a7f",
"assets/AssetManifest.bin": "7ed08066bf01f729f254fe65a870586e",
"assets/AssetManifest.bin.json": "62d7b7de188362259bd01f57b52d8bbd",
"assets/AssetManifest.json": "4d9f2044b641e0c32ee3b6939323e669",
"assets/assets/sample.xlsx": "fab2da56b89d80db2a87289e5babf114",
"assets/assets/srinivas%2520sign.png": "75578b46975adb9a0c183b96d3ae17bd",
"assets/FontManifest.json": "a056a4108c6ef6c915d9842e8ba342bb",
"assets/fonts/MaterialIcons-Regular.otf": "4d985cdbd1cd0f32f4b93d5c73af8ac0",
"assets/fonts/Poppins-ExtraBold.ttf": "6b78c7ec468eb0e13c6c5c4c39203986",
"assets/fonts/Poppins-Regular.ttf": "41e8dead03fb979ecc23b8dfb0fef627",
"assets/fonts/Poppins-SemiBold.ttf": "342ba3d8ac29ac8c38d7cef8efbf2dc9",
"assets/NOTICES": "ccfe5c66b0dcc954c89f9abf1e82f96f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "13120a6d9ca8df7d17d81139d7b49a0b",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "65643a5c0b14952d4f6dee3a12c10c55",
"/": "65643a5c0b14952d4f6dee3a12c10c55",
"main.dart.js": "20ba57d79793712d1841dc7a5955f9a5",
"manifest.json": "e1cbb2e91f4afaf4b633f52b810fac4b",
"version.json": "43034c300b57c75993547bf059c69f60"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
