<<<<<<< HEAD
(()=>{var I=()=>navigator.vendor==="Google Inc."||navigator.agent==="Edg/",T=()=>typeof ImageDecoder>"u"?!1:I(),E=()=>typeof Intl.v8BreakIterator<"u"&&typeof Intl.Segmenter<"u",S=()=>{let o=[0,97,115,109,1,0,0,0,1,5,1,95,1,120,0];return WebAssembly.validate(new Uint8Array(o))},p={hasImageCodecs:T(),hasChromiumBreakIterators:E(),supportsWasmGC:S(),crossOriginIsolated:window.crossOriginIsolated};var w=U(L());function L(){let o=document.querySelector("base");return o&&o.getAttribute("href")||""}function U(o){return o===""||o.endsWith("/")?o:`${o}/`}var f=class{constructor(){this._scriptLoaded=!1}setTrustedTypesPolicy(e){this._ttPolicy=e}async loadEntrypoint(e){let{entrypointUrl:n=`${w}main.dart.js`,onEntrypointLoaded:r,nonce:t}=e||{};return this._loadJSEntrypoint(n,r,t)}async load(e,n,r,t,i){if(i??=s=>{s.initializeEngine(r).then(a=>a.runApp())},e.compileTarget==="dart2wasm")return this._loadWasmEntrypoint(e,n,i);{let s=e.mainJsPath??"main.dart.js",a=`${w}${s}`;return this._loadJSEntrypoint(a,i,t)}}didCreateEngineInitializer(e){typeof this._didCreateEngineInitializerResolve=="function"&&(this._didCreateEngineInitializerResolve(e),this._didCreateEngineInitializerResolve=null,delete _flutter.loader.didCreateEngineInitializer),typeof this._onEntrypointLoaded=="function"&&this._onEntrypointLoaded(e)}_loadJSEntrypoint(e,n,r){let t=typeof n=="function";if(!this._scriptLoaded){this._scriptLoaded=!0;let i=this._createScriptTag(e,r);if(t)console.debug("Injecting <script> tag. Using callback."),this._onEntrypointLoaded=n,document.head.append(i);else return new Promise((s,a)=>{console.debug("Injecting <script> tag. Using Promises. Use the callback approach instead!"),this._didCreateEngineInitializerResolve=s,i.addEventListener("error",a),document.head.append(i)})}}async _loadWasmEntrypoint(e,n,r){if(!this._scriptLoaded){this._scriptLoaded=!0,this._onEntrypointLoaded=r;let{mainWasmPath:t,jsSupportRuntimePath:i}=e,s=`${w}${t}`,a=`${w}${i}`;this._ttPolicy!=null&&(a=this._ttPolicy.createScriptURL(a));let d=WebAssembly.compileStreaming(fetch(s)),c=await import(a),u;e.renderer==="skwasm"?u=(async()=>{let m=await n.skwasm;return window._flutter_skwasmInstance=m,{skwasm:m.wasmExports,skwasmWrapper:m,ffi:{memory:m.wasmMemory}}})():u={};let l=await c.instantiate(d,u);await c.invoke(l)}}_createScriptTag(e,n){let r=document.createElement("script");r.type="application/javascript",n&&(r.nonce=n);let t=e;return this._ttPolicy!=null&&(t=this._ttPolicy.createScriptURL(e)),r.src=t,r}};async function b(o,e,n){if(e<0)return o;let r,t=new Promise((i,s)=>{r=setTimeout(()=>{s(new Error(`${n} took more than ${e}ms to resolve. Moving on.`,{cause:b}))},e)});return Promise.race([o,t]).finally(()=>{clearTimeout(r)})}var h=class{setTrustedTypesPolicy(e){this._ttPolicy=e}loadServiceWorker(e){if(!e)return console.debug("Null serviceWorker configuration. Skipping."),Promise.resolve();if(!("serviceWorker"in navigator)){let a="Service Worker API unavailable.";return window.isSecureContext||(a+=`
The current context is NOT secure.`,a+=`
Read more: https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts`),Promise.reject(new Error(a))}let{serviceWorkerVersion:n,serviceWorkerUrl:r=`${w}flutter_service_worker.js?v=${n}`,timeoutMillis:t=4e3}=e,i=r;this._ttPolicy!=null&&(i=this._ttPolicy.createScriptURL(i));let s=navigator.serviceWorker.register(i).then(a=>this._getNewServiceWorker(a,n)).then(this._waitForServiceWorkerActivation);return b(s,t,"prepareServiceWorker")}async _getNewServiceWorker(e,n){if(!e.active&&(e.installing||e.waiting))return console.debug("Installing/Activating first service worker."),e.installing||e.waiting;if(e.active.scriptURL.endsWith(n))return console.debug("Loading from existing service worker."),e.active;{let r=await e.update();return console.debug("Updating service worker."),r.installing||r.waiting||r.active}}async _waitForServiceWorkerActivation(e){if(!e||e.state==="activated")if(e){console.debug("Service worker already active.");return}else throw new Error("Cannot activate a null service worker!");return new Promise((n,r)=>{e.addEventListener("statechange",()=>{e.state==="activated"&&(console.debug("Activated new service worker."),n())})})}};var v=class{constructor(e,n="flutter-js"){let r=e||[/\.js$/,/\.mjs$/];window.trustedTypes&&(this.policy=trustedTypes.createPolicy(n,{createScriptURL:function(t){if(t.startsWith("blob:"))return t;let i=new URL(t,window.location),s=i.pathname.split("/").pop();if(r.some(d=>d.test(s)))return i.toString();console.error("URL rejected by TrustedTypes policy",n,":",t,"(download prevented)")}}))}};var y=o=>{let e=WebAssembly.compileStreaming(fetch(o));return(n,r)=>((async()=>{let t=await e,i=await WebAssembly.instantiate(t,n);r(i,t)})(),{})};var C=(o,e,n,r)=>window.flutterCanvasKit?Promise.resolve(window.flutterCanvasKit):(window.flutterCanvasKitLoaded=new Promise((t,i)=>{let s=n.hasChromiumBreakIterators&&n.hasImageCodecs;if(!s&&e.canvasKitVariant=="chromium")throw"Chromium CanvasKit variant specifically requested, but unsupported in this browser";let a=s&&e.canvasKitVariant!=="full",d=e.canvasKitBaseUrl??`https://www.gstatic.com/flutter-canvaskit/${r}/`;a&&(d=`${d}chromium/`);let c=`${d}canvaskit.js`;o.flutterTT.policy&&(c=o.flutterTT.policy.createScriptURL(c));let u=y(`${d}canvaskit.wasm`),l=document.createElement("script");l.src=c,e.nonce&&(l.nonce=e.nonce),l.addEventListener("load",async()=>{try{let m=await CanvasKitInit({instantiateWasm:u});window.flutterCanvasKit=m,t(m)}catch(m){i(m)}}),l.addEventListener("error",i),document.head.appendChild(l)}),window.flutterCanvasKitLoaded);var _=(o,e,n,r)=>new Promise((t,i)=>{let s=e.canvasKitBaseUrl??`https://www.gstatic.com/flutter-canvaskit/${r}/`,a=`${s}skwasm.js`;o.flutterTT.policy&&(a=o.flutterTT.policy.createScriptURL(a));let d=y(`${s}skwasm.wasm`),c=document.createElement("script");c.src=a,e.nonce&&(c.nonce=e.nonce),c.addEventListener("load",async()=>{try{let u=await skwasm({instantiateWasm:d,locateFile:(l,m)=>{let k=m+l;return k.endsWith(".worker.js")?URL.createObjectURL(new Blob([`importScripts('${k}');`],{type:"application/javascript"})):k}});t(u)}catch(u){i(u)}}),c.addEventListener("error",i),document.head.appendChild(c)});var g=class{async loadEntrypoint(e){let{serviceWorker:n,...r}=e||{},t=new v,i=new h;i.setTrustedTypesPolicy(t.policy),await i.loadServiceWorker(n).catch(a=>{console.warn("Exception while loading service worker:",a)});let s=new f;return s.setTrustedTypesPolicy(t.policy),this.didCreateEngineInitializer=s.didCreateEngineInitializer.bind(s),s.loadEntrypoint(r)}async load({serviceWorkerSettings:e,onEntrypointLoaded:n,nonce:r,config:t}={}){t??={};let i=_flutter.buildConfig;if(!i)throw"FlutterLoader.load requires _flutter.buildConfig to be set";let s=l=>{switch(l){case"skwasm":return p.crossOriginIsolated&&p.hasChromiumBreakIterators&&p.hasImageCodecs&&p.supportsWasmGC;default:return!0}},a=l=>l.compileTarget==="dart2wasm"&&!p.supportsWasmGC||t.renderer&&t.renderer!=l.renderer?!1:s(l.renderer),d=i.builds.find(a);if(!d)throw"FlutterLoader could not find a build compatible with configuration and environment.";let c={};c.flutterTT=new v,e&&(c.serviceWorkerLoader=new h,c.serviceWorkerLoader.setTrustedTypesPolicy(c.flutterTT.policy),await c.serviceWorkerLoader.loadServiceWorker(e).catch(l=>{console.warn("Exception while loading service worker:",l)})),d.renderer==="canvaskit"?c.canvasKit=C(c,t,p,i.engineRevision):d.renderer==="skwasm"&&(c.skwasm=_(c,t,p,i.engineRevision));let u=new f;return u.setTrustedTypesPolicy(c.flutterTT.policy),this.didCreateEngineInitializer=u.didCreateEngineInitializer.bind(u),u.load(d,c,t,r,n)}};window._flutter||(window._flutter={});window._flutter.loader||(window._flutter.loader=new g);})();
//# sourceMappingURL=flutter.js.map
=======
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

if (!_flutter) {
  var _flutter = {};
}
_flutter.loader = null;

(function () {
  "use strict";

  const baseUri = ensureTrailingSlash(getBaseURI());

  function getBaseURI() {
    const base = document.querySelector("base");
    return (base && base.getAttribute("href")) || "";
  }

  function ensureTrailingSlash(uri) {
    if (uri == "") {
      return uri;
    }
    return uri.endsWith("/") ? uri : `${uri}/`;
  }

  /**
   * Wraps `promise` in a timeout of the given `duration` in ms.
   *
   * Resolves/rejects with whatever the original `promises` does, or rejects
   * if `promise` takes longer to complete than `duration`. In that case,
   * `debugName` is used to compose a legible error message.
   *
   * If `duration` is < 0, the original `promise` is returned unchanged.
   * @param {Promise} promise
   * @param {number} duration
   * @param {string} debugName
   * @returns {Promise} a wrapped promise.
   */
  async function timeout(promise, duration, debugName) {
    if (duration < 0) {
      return promise;
    }
    let timeoutId;
    const _clock = new Promise((_, reject) => {
      timeoutId = setTimeout(() => {
        reject(
          new Error(
            `${debugName} took more than ${duration}ms to resolve. Moving on.`,
            {
              cause: timeout,
            }
          )
        );
      }, duration);
    });

    return Promise.race([promise, _clock]).finally(() => {
      clearTimeout(timeoutId);
    });
  }

  /**
   * Handles the creation of a TrustedTypes `policy` that validates URLs based
   * on an (optional) incoming array of RegExes.
   */
  class FlutterTrustedTypesPolicy {
    /**
     * Constructs the policy.
     * @param {[RegExp]} validPatterns the patterns to test URLs
     * @param {String} policyName the policy name (optional)
     */
    constructor(validPatterns, policyName = "flutter-js") {
      const patterns = validPatterns || [
        /\.js$/,
      ];
      if (window.trustedTypes) {
        this.policy = trustedTypes.createPolicy(policyName, {
          createScriptURL: function(url) {
            const parsed = new URL(url, window.location);
            const file = parsed.pathname.split("/").pop();
            const matches = patterns.some((pattern) => pattern.test(file));
            if (matches) {
              return parsed.toString();
            }
            console.error(
              "URL rejected by TrustedTypes policy",
              policyName, ":", url, "(download prevented)");
          }
        });
      }
    }
  }

  /**
   * Handles loading/reloading Flutter's service worker, if configured.
   *
   * @see: https://developers.google.com/web/fundamentals/primers/service-workers
   */
  class FlutterServiceWorkerLoader {
    /**
     * Injects a TrustedTypesPolicy (or undefined if the feature is not supported).
     * @param {TrustedTypesPolicy | undefined} policy
     */
    setTrustedTypesPolicy(policy) {
      this._ttPolicy = policy;
    }

    /**
     * Returns a Promise that resolves when the latest Flutter service worker,
     * configured by `settings` has been loaded and activated.
     *
     * Otherwise, the promise is rejected with an error message.
     * @param {*} settings Service worker settings
     * @returns {Promise} that resolves when the latest serviceWorker is ready.
     */
    loadServiceWorker(settings) {
      if (settings == null) {
        // In the future, settings = null -> uninstall service worker?
        console.debug("Null serviceWorker configuration. Skipping.");
        return Promise.resolve();
      }
      if (!("serviceWorker" in navigator)) {
        let errorMessage = "Service Worker API unavailable.";
        if (!window.isSecureContext) {
          errorMessage += "\nThe current context is NOT secure."
          errorMessage += "\nRead more: https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts";
        }
        return Promise.reject(
          new Error(errorMessage)
        );
      }
      const {
        serviceWorkerVersion,
        serviceWorkerUrl = `${baseUri}flutter_service_worker.js?v=${serviceWorkerVersion}`,
        timeoutMillis = 4000,
      } = settings;

      // Apply the TrustedTypes policy, if present.
      let url = serviceWorkerUrl;
      if (this._ttPolicy != null) {
        url = this._ttPolicy.createScriptURL(url);
      }

      const serviceWorkerActivation = navigator.serviceWorker
        .register(url)
        .then(this._getNewServiceWorker)
        .then(this._waitForServiceWorkerActivation);

      // Timeout race promise
      return timeout(
        serviceWorkerActivation,
        timeoutMillis,
        "prepareServiceWorker"
      );
    }

    /**
     * Returns the latest service worker for the given `serviceWorkerRegistrationPromise`.
     *
     * This might return the current service worker, if there's no new service worker
     * awaiting to be installed/updated.
     *
     * @param {Promise<ServiceWorkerRegistration>} serviceWorkerRegistrationPromise
     * @returns {Promise<ServiceWorker>}
     */
    async _getNewServiceWorker(serviceWorkerRegistrationPromise) {
      const reg = await serviceWorkerRegistrationPromise;

      if (!reg.active && (reg.installing || reg.waiting)) {
        // No active web worker and we have installed or are installing
        // one for the first time. Simply wait for it to activate.
        console.debug("Installing/Activating first service worker.");
        return reg.installing || reg.waiting;
      } else if (!reg.active.scriptURL.endsWith(serviceWorkerVersion)) {
        // When the app updates the serviceWorkerVersion changes, so we
        // need to ask the service worker to update.
        return reg.update().then((newReg) => {
          console.debug("Updating service worker.");
          return newReg.installing || newReg.waiting || newReg.active;
        });
      } else {
        console.debug("Loading from existing service worker.");
        return reg.active;
      }
    }

    /**
     * Returns a Promise that resolves when the `latestServiceWorker` changes its
     * state to "activated".
     *
     * @param {Promise<ServiceWorker>} latestServiceWorkerPromise
     * @returns {Promise<void>}
     */
    async _waitForServiceWorkerActivation(latestServiceWorkerPromise) {
      const serviceWorker = await latestServiceWorkerPromise;

      if (!serviceWorker || serviceWorker.state == "activated") {
        if (!serviceWorker) {
          return Promise.reject(
            new Error("Cannot activate a null service worker!")
          );
        } else {
          console.debug("Service worker already active.");
          return Promise.resolve();
        }
      }
      return new Promise((resolve, _) => {
        serviceWorker.addEventListener("statechange", () => {
          if (serviceWorker.state == "activated") {
            console.debug("Activated new service worker.");
            resolve();
          }
        });
      });
    }
  }

  /**
   * Handles injecting the main Flutter web entrypoint (main.dart.js), and notifying
   * the user when Flutter is ready, through `didCreateEngineInitializer`.
   *
   * @see https://docs.flutter.dev/development/platform-integration/web/initialization
   */
  class FlutterEntrypointLoader {
    /**
     * Creates a FlutterEntrypointLoader.
     */
    constructor() {
      // Watchdog to prevent injecting the main entrypoint multiple times.
      this._scriptLoaded = false;
    }

    /**
     * Injects a TrustedTypesPolicy (or undefined if the feature is not supported).
     * @param {TrustedTypesPolicy | undefined} policy
     */
    setTrustedTypesPolicy(policy) {
      this._ttPolicy = policy;
    }

    /**
     * Loads flutter main entrypoint, specified by `entrypointUrl`, and calls a
     * user-specified `onEntrypointLoaded` callback with an EngineInitializer
     * object when it's done.
     *
     * @param {*} options
     * @returns {Promise | undefined} that will eventually resolve with an
     * EngineInitializer, or will be rejected with the error caused by the loader.
     * Returns undefined when an `onEntrypointLoaded` callback is supplied in `options`.
     */
    async loadEntrypoint(options) {
      const { entrypointUrl = `${baseUri}main.dart.js`, onEntrypointLoaded } =
        options || {};

      return this._loadEntrypoint(entrypointUrl, onEntrypointLoaded);
    }

    /**
     * Resolves the promise created by loadEntrypoint, and calls the `onEntrypointLoaded`
     * function supplied by the user (if needed).
     *
     * Called by Flutter through `_flutter.loader.didCreateEngineInitializer` method,
     * which is bound to the correct instance of the FlutterEntrypointLoader by
     * the FlutterLoader object.
     *
     * @param {Function} engineInitializer @see https://github.com/flutter/engine/blob/main/lib/web_ui/lib/src/engine/js_interop/js_loader.dart#L42
     */
    didCreateEngineInitializer(engineInitializer) {
      if (typeof this._didCreateEngineInitializerResolve === "function") {
        this._didCreateEngineInitializerResolve(engineInitializer);
        // Remove the resolver after the first time, so Flutter Web can hot restart.
        this._didCreateEngineInitializerResolve = null;
        // Make the engine revert to "auto" initialization on hot restart.
        delete _flutter.loader.didCreateEngineInitializer;
      }
      if (typeof this._onEntrypointLoaded === "function") {
        this._onEntrypointLoaded(engineInitializer);
      }
    }

    /**
     * Injects a script tag into the DOM, and configures this loader to be able to
     * handle the "entrypoint loaded" notifications received from Flutter web.
     *
     * @param {string} entrypointUrl the URL of the script that will initialize
     *                 Flutter.
     * @param {Function} onEntrypointLoaded a callback that will be called when
     *                   Flutter web notifies this object that the entrypoint is
     *                   loaded.
     * @returns {Promise | undefined} a Promise that resolves when the entrypoint
     *                                is loaded, or undefined if `onEntrypointLoaded`
     *                                is a function.
     */
    _loadEntrypoint(entrypointUrl, onEntrypointLoaded) {
      const useCallback = typeof onEntrypointLoaded === "function";

      if (!this._scriptLoaded) {
        this._scriptLoaded = true;
        const scriptTag = this._createScriptTag(entrypointUrl);
        if (useCallback) {
          // Just inject the script tag, and return nothing; Flutter will call
          // `didCreateEngineInitializer` when it's done.
          console.debug("Injecting <script> tag. Using callback.");
          this._onEntrypointLoaded = onEntrypointLoaded;
          document.body.append(scriptTag);
        } else {
          // Inject the script tag and return a promise that will get resolved
          // with the EngineInitializer object from Flutter when it calls
          // `didCreateEngineInitializer` later.
          return new Promise((resolve, reject) => {
            console.debug(
              "Injecting <script> tag. Using Promises. Use the callback approach instead!"
            );
            this._didCreateEngineInitializerResolve = resolve;
            scriptTag.addEventListener("error", reject);
            document.body.append(scriptTag);
          });
        }
      }
    }

    /**
     * Creates a script tag for the given URL.
     * @param {string} url
     * @returns {HTMLScriptElement}
     */
    _createScriptTag(url) {
      const scriptTag = document.createElement("script");
      scriptTag.type = "application/javascript";
      // Apply TrustedTypes validation, if available.
      let trustedUrl = url;
      if (this._ttPolicy != null) {
        trustedUrl = this._ttPolicy.createScriptURL(url);
      }
      scriptTag.src = trustedUrl;
      return scriptTag;
    }
  }

  /**
   * The public interface of _flutter.loader. Exposes two methods:
   * * loadEntrypoint (which coordinates the default Flutter web loading procedure)
   * * didCreateEngineInitializer (which is called by Flutter to notify that its
   *                              Engine is ready to be initialized)
   */
  class FlutterLoader {
    /**
     * Initializes the Flutter web app.
     * @param {*} options
     * @returns {Promise?} a (Deprecated) Promise that will eventually resolve
     *                     with an EngineInitializer, or will be rejected with
     *                     any error caused by the loader. Or Null, if the user
     *                     supplies an `onEntrypointLoaded` Function as an option.
     */
    async loadEntrypoint(options) {
      const { serviceWorker, ...entrypoint } = options || {};

      // A Trusted Types policy that is going to be used by the loader.
      const flutterTT = new FlutterTrustedTypesPolicy();

      // The FlutterServiceWorkerLoader instance could be injected as a dependency
      // (and dynamically imported from a module if not present).
      const serviceWorkerLoader = new FlutterServiceWorkerLoader();
      serviceWorkerLoader.setTrustedTypesPolicy(flutterTT.policy);
      await serviceWorkerLoader.loadServiceWorker(serviceWorker).catch(e => {
        // Regardless of what happens with the injection of the SW, the show must go on
        console.warn("Exception while loading service worker:", e);
      });

      // The FlutterEntrypointLoader instance could be injected as a dependency
      // (and dynamically imported from a module if not present).
      const entrypointLoader = new FlutterEntrypointLoader();
      entrypointLoader.setTrustedTypesPolicy(flutterTT.policy);
      // Install the `didCreateEngineInitializer` listener where Flutter web expects it to be.
      this.didCreateEngineInitializer =
        entrypointLoader.didCreateEngineInitializer.bind(entrypointLoader);
      return entrypointLoader.loadEntrypoint(entrypoint);
    }
  }

  _flutter.loader = new FlutterLoader();
})();
>>>>>>> b440bf075794fb249edb7657fd5be50f72700409
