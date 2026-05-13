<template>
  <q-header class="investor-header" elevated reveal reveal-offset="80">
    <div class="header-glow" aria-hidden="true" />

    <q-toolbar class="toolbar-inner q-px-md q-py-sm">
      <router-link to="/project" class="brand-link row items-center no-wrap">
        <span class="brand-mark" />
        <span class="brand-text text-weight-bold">{{ SITE.projectName }}</span>
      </router-link>

      <q-space />

      <nav class="nav-pills row items-center no-wrap q-gutter-xs">
        <q-btn
          v-for="item in nav"
          :key="item.to"
          flat
          dense
          no-caps
          rounded
          class="nav-btn"
          :class="{ 'nav-btn--active': isActive(item.to) }"
          :to="item.to"
        >
          <q-icon :name="item.icon" size="18px" class="q-mr-xs" />
          {{ item.label }}
        </q-btn>
      </nav>

      <q-space class="gt-xs" />

      <q-btn
        round
        flat
        dense
        icon="mail"
        class="gt-xs mail-icon-btn"
        aria-label="Contact"
        @click="contact.openDialog()"
      />
    </q-toolbar>
  </q-header>
</template>

<script setup>
import { useRoute } from 'vue-router'
import { SITE } from 'src/constants/site'
import { useContactUiStore } from 'src/stores/contact-ui'

const route = useRoute()
const contact = useContactUiStore()

const nav = [
  { to: '/project', label: 'Project', icon: 'auto_awesome' },
  { to: '/invest', label: 'Invest', icon: 'trending_up' },
  { to: '/future', label: 'Roadmap', icon: 'map' }
]

function isActive (path) {
  return route.path === path || route.path === `${path}/`
}
</script>

<style scoped>
.investor-header {
  position: relative;
  background: linear-gradient(
    120deg,
    rgba(76, 29, 149, 0.92) 0%,
    rgba(49, 46, 129, 0.95) 45%,
    rgba(30, 27, 75, 0.98) 100%
  );
  backdrop-filter: blur(12px);
  border-bottom: 1px solid rgba(196, 181, 253, 0.25);
}
.header-glow {
  position: absolute;
  inset: 0;
  pointer-events: none;
  background: radial-gradient(
    120% 80% at 10% 0%,
    rgba(167, 139, 250, 0.45) 0%,
    transparent 55%
  );
  animation: header-shimmer 8s ease-in-out infinite alternate;
}
@keyframes header-shimmer {
  from {
    opacity: 0.55;
    transform: translateX(0);
  }
  to {
    opacity: 1;
    transform: translateX(12px);
  }
}
.toolbar-inner {
  position: relative;
  z-index: 1;
  max-width: 1200px;
  margin: 0 auto;
  width: 100%;
}
.brand-link {
  text-decoration: none;
  color: inherit;
  gap: 10px;
}
.brand-mark {
  width: 10px;
  height: 36px;
  border-radius: 6px;
  background: linear-gradient(180deg, #c4b5fd 0%, #7c3aed 50%, #5b21b6 100%);
  box-shadow: 0 0 24px rgba(167, 139, 250, 0.65);
  animation: brand-pulse 2.8s ease-in-out infinite;
}
@keyframes brand-pulse {
  0%,
  100% {
    transform: scaleY(1);
    filter: brightness(1);
  }
  50% {
    transform: scaleY(1.06);
    filter: brightness(1.15);
  }
}
.brand-text {
  font-size: 1.35rem;
  letter-spacing: 0.04em;
  background: linear-gradient(90deg, #f5f3ff 0%, #ddd6fe 45%, #c4b5fd 100%);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}
.nav-btn {
  color: rgba(237, 233, 254, 0.85);
  font-weight: 600;
  padding: 6px 14px;
  transition:
    color 0.2s ease,
    background 0.2s ease,
    box-shadow 0.2s ease;
}
.nav-btn:hover {
  color: #fff;
  background: rgba(255, 255, 255, 0.08);
}
.nav-btn--active {
  color: #1e1b4b !important;
  background: linear-gradient(135deg, #ede9fe 0%, #c4b5fd 100%) !important;
  box-shadow: 0 8px 28px rgba(91, 33, 182, 0.35);
}
.mail-icon-btn {
  color: #ede9fe;
}

@media (max-width: 599px) {
  .nav-pills {
    flex-wrap: wrap;
    justify-content: flex-end;
    max-width: 58vw;
  }
  .nav-btn {
    font-size: 0.78rem;
    padding: 4px 8px;
  }
  .brand-text {
    font-size: 1.1rem;
  }
}
</style>
