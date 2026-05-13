<template>
  <q-layout view="hHh lpR fFf" class="investor-layout">
    <InvestorNavBar />

    <q-page-container class="page-container">
      <router-view v-slot="{ Component }">
        <transition name="fade-slide" mode="out-in">
          <component :is="Component" />
        </transition>
      </router-view>
    </q-page-container>

    <q-btn
      fab
      icon="mail"
      color="primary"
      text-color="white"
      class="fab-contact shadow-lg fixed-fab"
      aria-label="Contact us"
      @click="contact.openDialog()"
    >
      <q-tooltip anchor="center left" self="center right" :offset="[8, 0]">
        Contact us
      </q-tooltip>
    </q-btn>

    <ContactUsDialog v-model="dialogOpen" />
  </q-layout>
</template>

<script setup>
import { storeToRefs } from 'pinia'
import InvestorNavBar from 'src/components/investor/InvestorNavBar.vue'
import ContactUsDialog from 'src/components/investor/ContactUsDialog.vue'
import { useContactUiStore } from 'src/stores/contact-ui'

const contact = useContactUiStore()
const { dialogOpen } = storeToRefs(contact)
</script>

<style scoped>
.investor-layout {
  background: radial-gradient(
      120% 60% at 50% -10%,
      rgba(124, 58, 237, 0.35) 0%,
      transparent 55%
    ),
    linear-gradient(180deg, #0f172a 0%, #0b1020 40%, #070a12 100%);
  min-height: 100vh;
}
.page-container {
  max-width: 1200px;
  margin: 0 auto;
  width: 100%;
}
.fab-contact {
  box-shadow: 0 12px 40px rgba(91, 33, 182, 0.55);
}
.fixed-fab {
  position: fixed;
  right: 18px;
  bottom: 18px;
  z-index: 6000;
}
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition:
    opacity 0.28s ease,
    transform 0.28s ease;
}
.fade-slide-enter-from {
  opacity: 0;
  transform: translateY(10px);
}
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(-6px);
}
</style>
