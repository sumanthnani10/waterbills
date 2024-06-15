'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

<<<<<<< HEAD
const RESOURCES = {"assets/AssetManifest.bin": "7ed08066bf01f729f254fe65a870586e",
"assets/AssetManifest.bin.json": "62d7b7de188362259bd01f57b52d8bbd",
=======
const RESOURCES = {".git/COMMIT_EDITMSG": "74b65abe6cd3af4c22adfd3fe940641c",
".git/config": "32f47c4478863ba356cd2c976cc05102",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "7185d3a5e32f0c52670ce2fe21880884",
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
".git/index": "c19da0edd3be7856ebe311d3f84f9845",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "71851df840e3c6509a8628ba0c059b68",
".git/logs/refs/heads/master": "71851df840e3c6509a8628ba0c059b68",
".git/logs/refs/remotes/origin/master": "35afe87a1059a3f92f5399a266c610a1",
".git/objects/03/eaddffb9c0e55fb7b5f9b378d9134d8d75dd37": "87850ce0a3dd72f458581004b58ac0d6",
".git/objects/0d/d8a3ff8d13e78e32a42af8cf5a2fe8f8252c94": "7ff7a74da276268f8a9bfbed7545a39d",
".git/objects/0f/816fb5068fb5d0dc1623718a94d7a34c5edfe4": "48392ce692d6328aef69a753fa305233",
".git/objects/13/cd698afa86edb334bec59991cd113491a5a4f1": "01d69635e49925db17e7c32e26fc974f",
".git/objects/15/9b15011009e1e691b0761e5627dc3f3aa452ad": "822c0ced8e90203ed87ff7e0082d7945",
".git/objects/1b/39032c1209617f1207d5451a3b2e751c4be99a": "b6cee4c28eeab66d5695cd005b26b3bb",
".git/objects/1c/92640b6c0c6966d4829a9bfa94b9d80ac0a45a": "815daa10d4b8b0506cf462e222fa2fca",
".git/objects/1d/384f3748038966a5c7316223edf120dd5894dd": "a8d542276aa823dfefb8d26439e1077a",
".git/objects/1e/bd7b7b7c1491eb397d4d873ce834f51b84b3ab": "ce2966bb6ca0facb9c44d834035da84c",
".git/objects/1e/f4982f67f4c3111983260806f538044de9d20b": "b2084d0aad40e860b932c3f982eb3d63",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/25/27a287a6bd07e19f0c691ac6df77078df2e676": "c59f241c6bb14edb5df1f4e26cded123",
".git/objects/27/3d65379f1f7f1f051016f14003a265899bece0": "66c341ed461c83da3d2431b18449ae6f",
".git/objects/32/46ad559eeae0370195978eaed83f1053ee13fd": "a043dbc0a0bda96ce2127799ccc27506",
".git/objects/35/1850a671af31ac5f9ea884aace02211faa9a43": "75cb956290b329fb27bc50efb3482e9d",
".git/objects/3b/8622f67bffda70fc2d7f6ff2f2ad6f3078fd08": "731b64a59569a859ccc7057722b737a4",
".git/objects/43/bc7fb55cae8a5b8d1f23cf508b75c488002af4": "6dee07a1fbf439905d2a0f6f08f567b7",
".git/objects/44/1d3baab4f3bfc1ce251942e420988fac12a8f4": "ac3a2ba50af07d40313ad29d8023a3b1",
".git/objects/44/94a2e39be8e155269769b2fe796ab6a3901134": "0b7e7a7548a67c7ec1b9d479ec0d3e88",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/48/d6117e84cca19d53bd1aefc489b4798f44915a": "aadebb5bb2625cc8a930efa59428f759",
".git/objects/4b/733ab01f8d7753c1a31cdcfd98d7341e6655dc": "6c66fab5a86526e0e6819964fc558678",
".git/objects/4b/825dc642cb6eb9a060e54bf8d69288fbee4904": "75589287973d2772c2fc69d664e10822",
".git/objects/4d/d6c67ad3a13c8c1aa6de5659ce67e18be0a193": "fcd80de52e6ef54eda49c6923c041616",
".git/objects/52/cfb77a424101413b81e246b965151f443a0e85": "453827b9337fef0116c048dee437d21d",
".git/objects/62/28cd90f08182349a12bf67d382e94c5d6f6a3a": "f69e7fe75b991d55d8a991ec3255c9b9",
".git/objects/62/a01d6826913d9efa140d2e9f4bc0f13918e607": "44ba2af6a4f05cb190463143170ae010",
".git/objects/63/ca00ff9e688702e8dd9981c77c7eecec811f2f": "b759b30c65b2d9722aae613462307aec",
".git/objects/64/b86436dabc51feae053691a6db175dc198b885": "f75c64c60a46da7f67b416f65c052a55",
".git/objects/6f/2f3754eccf0edc494fff5d15bb67f6a044e817": "56d64fb0b62584cd35821b3849d9fdda",
".git/objects/70/beb28e3b0751ffc5ddb8e62304ffef8c5c1737": "52cf00fb919de353f00afb05381d9c81",
".git/objects/71/1381263247b2312814adebe689552fac7a57c1": "1ab47c89c77bf761757bdb36ef342638",
".git/objects/79/062802c44bd9b54c9c7b974944758dfd18a7cf": "493793cb5462cc748b1cf57817d00cbe",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/81/0337fcab9374ea7916511a5b9b59c1fe38c5fd": "cc99e87ef5a5ad26f76eb93e555d98fa",
".git/objects/82/1eace41e6b079c013bf4f05aa3b122ba7a38cb": "d9b74bc6950f317edb8592f24443fc81",
".git/objects/83/a9877f36b1e9786ba70d26d698fa67a96c4877": "2df6337f40b7138ec112ff60d390befe",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8e/7f4b338840099949781ab85496d7a67fae46f1": "7f2803c236e9e7d95ef6ed16a3a2bd13",
".git/objects/95/19e1d75e8e60fc461d42dceff7162076484747": "87166efde232eca9c4f1ad4118b6d046",
".git/objects/96/1fb01aa6554c094e3bee646d803b8c657ac840": "b5e535cd9d45590b98d2e0f53a8809f6",
".git/objects/98/0ba3f7963a12f74efffa1c865947c67614d7e7": "494fe7ffcc7fd8a65fb6ff7370c4979c",
".git/objects/98/7975fc0334775cec59902798235f2b79d69c9c": "b41605d09273d86ea29b55eb140610fe",
".git/objects/99/0e4a895dc37046535b755ea5fdf184329b6631": "00ca2d9eb45b96186aaa03d29106fe4b",
".git/objects/9e/691576b637439cbf9344a5d76e8b5f6f53d5af": "938af45f5a97dd2c89f78481a7ce78f3",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/a4/49b1a71fbd3b41e0a1077bbf6b9674f8e26341": "e25a0949803339ae10c61bdb88d2e1dc",
".git/objects/ab/0e98497a51ead7821d1da35a24968ff314e50f": "557c35fe3928eb2af403d1b3926bb9ba",
".git/objects/ad/b4e96119c83ad45906a3cc658fc5bedeefdaa6": "f31b85dd89580976e03fe418d242e0dd",
".git/objects/ae/37803d1933c3979fd1b939ff61cc667b0b70dc": "f5c08c98e82ebd9034dbd78b64a292fa",
".git/objects/b6/847af84668f859e670bc343cb1767c5f9fb9a1": "2b1c613b00e1262af4bd1c864593130b",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/bd/0f8426ca637824d031ef8ad6e99f38361f683b": "b9095f5e189425a60249cfa9bb2d320c",
".git/objects/c2/ac5271cc8c6e5efa25bd47afc0adadb2d0ec3a": "1f42f457419d2f0cb704b3f1e5768778",
".git/objects/c2/d834be28507165c134ead0c40ad823cd31b6af": "a8a2a844b7c3087187437e90ddbfc96f",
".git/objects/c3/bdb59b5250c939f15e6ea7e62e3e149ca11024": "85bfe7a3e2f7920e2fe6c8973e894b73",
".git/objects/ca/4df9c0d4e27a6889800791833c0f40fa31e738": "87e1b3a00fab4baf0f8b7c8bb3f0ede3",
".git/objects/cf/6d83222ea60b3f10608f3ff76c1ad2260fc044": "7c65d126fa78d5c45c97951888064227",
".git/objects/d3/efa7fd80d9d345a1ad0aaa2e690c38f65f4d4e": "610858a6464fa97567f7cce3b11d9508",
".git/objects/d5/77aff5819a02f19a4509c06225176b758774ed": "646568a11e2f844bb4f338f9a53165e6",
".git/objects/dd/56eabbf298449db91bfa8644c6fbb20b8e6dda": "3fa6bb294070401dbba0b01792b84ce0",
".git/objects/e4/8d8fe1bcfc2b4f85be12156fe003f23917dabc": "84b353fd870940a026af86986dcbfa93",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/e7/3b5df783a1bd3d87e225eeb7e44cc561115ef9": "9e94fd53551c77ffd6a7ddd32030b210",
".git/objects/e7/5e920f175da53dd6f04d858636baa25dc702f4": "0fd694d0b7477cee41611e70d0cd6732",
".git/objects/e9/147cd7ae40d5915f5b18ba7b77717431e705f8": "5019e0b0626246f41ae3032e99cbc9c0",
".git/objects/ec/ee7878b5b9d881cfd8904a3bfa7661745559f6": "c1a1c334190020c048d1afee76c0f104",
".git/objects/f4/7daeea4ab7f121c60e3a80670d7a9ec6020969": "d2669a5a34ce241ca9f0fcee5fc31a47",
".git/objects/f6/0154dc622c980f364331f323d04cbd2daf9ce7": "38edf90cf12d856db8abb57cc55b91c7",
".git/objects/f6/e52aba1f3dcf8554156ac72cefec74bb75d100": "7414976859ecd15ae10681e0f2ff003d",
".git/objects/fb/149277c05752b604e4ace39a4b40dc47e6f2c2": "43395ce93800277bcc2a3ec5025c8dea",
".git/objects/fb/f57e78a43b8ff1af992dfcab7551f2c98b0007": "e6138d2209987f9ac4962fabe1f9fe36",
".git/objects/fc/565ec170b7fd55cbf422b8188a6f64eddda60e": "c1d5b622c8e63d1865785872c9d4a21d",
".git/ORIG_HEAD": "7f7e4595a31b9aa2647ee60255ab2404",
".git/refs/heads/master": "7f7e4595a31b9aa2647ee60255ab2404",
".git/refs/remotes/origin/master": "7f7e4595a31b9aa2647ee60255ab2404",
"assets/AssetManifest.bin": "7e9b610e9b37aa82920c2c2e124a3c2a",
>>>>>>> b440bf075794fb249edb7657fd5be50f72700409
"assets/AssetManifest.json": "4d9f2044b641e0c32ee3b6939323e669",
"assets/assets/sample.xlsx": "fab2da56b89d80db2a87289e5babf114",
"assets/assets/srinivas%2520sign.png": "75578b46975adb9a0c183b96d3ae17bd",
"assets/FontManifest.json": "a056a4108c6ef6c915d9842e8ba342bb",
<<<<<<< HEAD
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
"flutter_bootstrap.js": "e1f3eb1d7a3df4e0015692ee2026f515",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "fca53e3b51cc210aa6bf8f6a89e511f2",
"/": "fca53e3b51cc210aa6bf8f6a89e511f2",
"main.dart.js": "20ba57d79793712d1841dc7a5955f9a5",
"manifest.json": "e1cbb2e91f4afaf4b633f52b810fac4b",
=======
"assets/fonts/MaterialIcons-Regular.otf": "ea1115f56b143a0d536d867fecf973e3",
"assets/fonts/Poppins-ExtraBold.ttf": "6b78c7ec468eb0e13c6c5c4c39203986",
"assets/fonts/Poppins-Regular.ttf": "41e8dead03fb979ecc23b8dfb0fef627",
"assets/fonts/Poppins-SemiBold.ttf": "342ba3d8ac29ac8c38d7cef8efbf2dc9",
"assets/NOTICES": "bf53eadbfe2425a37b4a247da4e3492f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "57f2f020e63be0dd85efafc7b7b25d80",
"canvaskit/canvaskit.js": "73df95dcc5f14b78d234283bf1dd2fa7",
"canvaskit/canvaskit.wasm": "d3105230aad263f43ca0388a51e43598",
"canvaskit/chromium/canvaskit.js": "cc1b69a365ddc1241a9cad98f28dd9b6",
"canvaskit/chromium/canvaskit.wasm": "f3da99572bed65fc644f1e7f72cf7167",
"canvaskit/skwasm.js": "d26e50adf287aa04d3f2ede5d3873f69",
"canvaskit/skwasm.wasm": "2eb2817ce6951167562e9ddadd486376",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "cec725327bc55485e1e4200d656d63c5",
"/": "cec725327bc55485e1e4200d656d63c5",
"main.dart.js": "07fd029ec4b5c778cb21ae4160cec794",
"manifest.json": "938f8d14e49f1eb9881ef62a91e089d1",
>>>>>>> b440bf075794fb249edb7657fd5be50f72700409
"version.json": "43034c300b57c75993547bf059c69f60"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
<<<<<<< HEAD
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
=======
"assets/AssetManifest.json",
>>>>>>> b440bf075794fb249edb7657fd5be50f72700409
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
