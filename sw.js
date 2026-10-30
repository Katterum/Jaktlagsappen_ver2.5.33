const C='jaktlaget-v2533-clean-stable-20261030';
const CORE=['./index.html','./style.css?v=2533','./app.js?v=2533','./cloud.js?v=2533','./supabase-config.js','./master-data-v250.json'];
self.addEventListener('install',e=>{self.skipWaiting();e.waitUntil(caches.open(C).then(c=>c.addAll(CORE)))});
self.addEventListener('activate',e=>e.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k!==C).map(k=>caches.delete(k)))).then(()=>self.clients.claim())));
self.addEventListener('fetch',e=>{if(e.request.method!=='GET')return;e.respondWith(fetch(e.request,{cache:'no-store'}).then(r=>{if(r.ok)caches.open(C).then(c=>c.put(e.request,r.clone()));return r}).catch(()=>caches.match(e.request)))});
