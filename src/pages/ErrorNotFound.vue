<template>
  <div class="fullscreen not-found text-white text-center q-pa-md flex flex-center">
    <div>
      <div class="code">404</div>

      <div class="text-h5 text-weight-medium q-mt-md" style="opacity: 0.75">
        This page does not exist.
      </div>

      <q-btn
        class="q-mt-xl"
        color="primary"
        text-color="white"
        unelevated
        no-caps
        rounded
        padding="sm lg"
        to="/"
        label="Back to site"
      />
    </div>
  </div>
</template>

<style scoped>
.not-found {
  background: radial-gradient(
      80% 60% at 50% 0%,
      rgba(124, 58, 237, 0.45) 0%,
      transparent 55%
    ),
    linear-gradient(180deg, #0f172a 0%, #070a12 100%);
}
.code {
  font-size: clamp(4rem, 22vw, 12rem);
  font-weight: 800;
  line-height: 1;
  letter-spacing: -0.04em;
  background: linear-gradient(135deg, #ede9fe 0%, #a78bfa 40%, #7c3aed 100%);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}
</style>
