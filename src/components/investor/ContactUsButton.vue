<template>
  <q-btn
    unelevated
    no-caps
    padding="sm lg"
    class="contact-inline-btn"
    :class="{ 'contact-inline-btn--solid': !outline && !flat }"
    :outline="outline"
    :flat="flat"
    :size="size"
    :label="label"
    :color="outline ? 'primary' : flat ? undefined : 'primary'"
    :text-color="outline || flat ? undefined : 'white'"
    icon-right="arrow_forward"
    @click="contact.openDialog()"
  />
</template>

<script setup>
import { useContactUiStore } from 'src/stores/contact-ui'

defineProps({
  label: { type: String, default: 'Contact us' },
  outline: { type: Boolean, default: false },
  flat: { type: Boolean, default: false },
  size: { type: String, default: 'md' }
})

const contact = useContactUiStore()
</script>

<style scoped>
/* On deep violet UIs, pure Quasar contrast can read too dark — tune explicitly. */
.contact-inline-btn {
  border-radius: 12px;
  font-weight: 600;
}

.contact-inline-btn--solid {
  background: linear-gradient(135deg, #a78bfa 0%, #7c3aed 42%, #6d28d9 100%) !important;
  color: #faf5ff !important;
  border: 1px solid rgba(255, 255, 255, 0.22);
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.2),
    0 4px 16px rgba(91, 33, 182, 0.45);
  text-shadow: 0 1px 2px rgba(49, 46, 129, 0.45);
}

.contact-inline-btn--solid :deep(.q-btn__wrapper) {
  color: #faf5ff !important;
}

.contact-inline-btn--solid :deep(.q-icon) {
  color: #ede9fe !important;
  opacity: 0.95;
}

.contact-inline-btn--solid:hover :deep(.q-focus-helper) {
  opacity: 0.18 !important;
}

.contact-inline-btn.q-btn--outline {
  color: #ede9fe !important;
  border-color: rgba(196, 181, 253, 0.55) !important;
  background: rgba(124, 58, 237, 0.12) !important;
}

.contact-inline-btn.q-btn--outline :deep(.q-btn__wrapper),
.contact-inline-btn.q-btn--outline :deep(.q-icon) {
  color: #ede9fe !important;
}

.contact-inline-btn.q-btn--flat {
  color: #ddd6fe !important;
}

.contact-inline-btn.q-btn--flat :deep(.q-icon) {
  color: #c4b5fd !important;
}
</style>
