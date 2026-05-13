<template>
  <q-dialog
    :model-value="modelValue"
    class="contact-dlg"
    @update:model-value="$emit('update:modelValue', $event)"
  >
    <q-card flat bordered class="contact-card">
      <q-card-section class="contact-header row items-start no-wrap q-pa-lg q-pb-md">
        <div class="col">
          <div class="cd-title text-h6 text-weight-bold">Contact us</div>
          <div class="cd-subtitle text-caption q-mt-xs">
            We typically reply within one business day.
          </div>
        </div>
        <q-btn
          flat
          round
          dense
          icon="close"
          class="cd-close"
          v-close-popup
          @click="$emit('update:modelValue', false)"
        />
      </q-card-section>

      <q-separator class="cd-sep" />

      <q-card-section class="q-px-lg q-pt-lg q-gutter-md">
        <q-input
          v-model="name"
          outlined
          dense
          label="Your name"
          class="cd-field"
          color="primary"
        />
        <q-input
          v-model="email"
          outlined
          dense
          type="email"
          label="Work email"
          class="cd-field"
          color="primary"
        />
        <q-input
          v-model="message"
          outlined
          type="textarea"
          autogrow
          label="How can we help?"
          class="cd-field"
          color="primary"
        />
      </q-card-section>

      <q-card-actions align="right" class="contact-actions q-px-lg q-pb-lg q-pt-sm">
        <q-btn
          flat
          no-caps
          rounded
          label="Cancel"
          class="cd-btn-cancel"
          v-close-popup
        />
        <q-btn
          unelevated
          no-caps
          rounded
          class="cd-btn-submit"
          label="Open email"
          icon="mail"
          @click="sendMail"
        />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref } from 'vue'
import { useQuasar } from 'quasar'
import { SITE } from 'src/constants/site'

defineProps({
  modelValue: { type: Boolean, required: true }
})

const emit = defineEmits(['update:modelValue'])

const $q = useQuasar()

const name = ref('')
const email = ref('')
const message = ref('')

function sendMail () {
  const subject = encodeURIComponent(`${SITE.projectName} — investor inquiry`)
  const body = encodeURIComponent(
    `Name: ${name.value}\nEmail: ${email.value}\n\n${message.value}\n`
  )
  const mailto = `mailto:${SITE.contactEmail}?subject=${subject}&body=${body}`
  window.location.href = mailto
  emit('update:modelValue', false)
  $q.notify({
    type: 'positive',
    message: 'Your mail client should open shortly.',
    position: 'top'
  })
}
</script>

<style scoped>
.contact-card {
  --cd-high: #faf5ff;
  --cd-body: #e9e5ff;
  --cd-muted: #c4b5fd;
  --cd-soft: #a78bfa;
  --cd-field-bg: rgba(30, 27, 75, 0.55);
  --cd-border: rgba(196, 181, 253, 0.38);
  --cd-border-soft: rgba(167, 139, 250, 0.22);

  width: min(100vw - 32px, 440px);
  border-radius: 18px;
  overflow: hidden;
  background: linear-gradient(
    165deg,
    rgba(49, 46, 129, 0.97) 0%,
    rgba(30, 27, 75, 0.98) 42%,
    rgba(15, 23, 42, 0.99) 100%
  );
  border: 1px solid var(--cd-border);
  box-shadow:
    0 0 0 1px rgba(124, 58, 237, 0.12),
    0 24px 56px rgba(15, 23, 42, 0.75),
    0 0 80px rgba(91, 33, 182, 0.25);
}

.cd-title {
  color: var(--cd-high);
  letter-spacing: 0.02em;
}

.cd-subtitle {
  color: var(--cd-muted);
  line-height: 1.45;
  max-width: 17rem;
}

.cd-close {
  color: var(--cd-muted) !important;
  margin-top: -4px;
}

.cd-close:hover :deep(.q-focus-helper) {
  background: rgba(167, 139, 250, 0.15) !important;
}

.cd-sep {
  background: rgba(196, 181, 253, 0.18);
  opacity: 1;
}

.contact-actions {
  border-top: 1px solid rgba(196, 181, 253, 0.12);
  background: rgba(15, 23, 42, 0.35);
}

/* ---- Form fields ---- */
.cd-field :deep(.q-field__control) {
  color: var(--cd-high);
  background: var(--cd-field-bg);
  border-radius: 12px;
}

.cd-field :deep(.q-field__native),
.cd-field :deep(.q-field__input) {
  color: var(--cd-high) !important;
  caret-color: #c4b5fd;
}

.cd-field :deep(.q-field__native)::placeholder {
  color: rgba(196, 181, 253, 0.55);
}

.cd-field :deep(.q-field__label) {
  color: var(--cd-soft) !important;
}

.cd-field :deep(.q-field--float .q-field__label),
.cd-field :deep(.q-field--highlighted .q-field__label) {
  color: var(--cd-muted) !important;
}

.cd-field :deep(.q-field__marginal) {
  color: var(--cd-soft);
}

.cd-field :deep(.q-field--outlined .q-field__control:before) {
  border-color: var(--cd-border-soft) !important;
}

.cd-field :deep(.q-field--outlined:hover .q-field__control:before) {
  border-color: rgba(196, 181, 253, 0.42) !important;
}

.cd-field :deep(.q-field--outlined.q-field--focused .q-field__control:before) {
  border-color: rgba(167, 139, 250, 0.75) !important;
  box-shadow: 0 0 0 1px rgba(124, 58, 237, 0.25);
}

.cd-field :deep(.q-field--outlined.q-field--focused .q-field__control:after) {
  border-width: 2px !important;
  border-color: #a78bfa !important;
}

.cd-field :deep(textarea.q-field__native) {
  min-height: 88px;
}

/* ---- Buttons ---- */
.cd-btn-cancel {
  color: var(--cd-muted) !important;
  font-weight: 600;
}

.cd-btn-cancel:hover :deep(.q-focus-helper) {
  background: rgba(167, 139, 250, 0.12) !important;
}

.cd-btn-submit {
  padding: 8px 18px;
  font-weight: 600;
  color: #faf5ff !important;
  background: linear-gradient(135deg, #a78bfa 0%, #7c3aed 45%, #6d28d9 100%) !important;
  border: 1px solid rgba(255, 255, 255, 0.22);
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.18),
    0 6px 20px rgba(91, 33, 182, 0.45);
  text-shadow: 0 1px 2px rgba(49, 46, 129, 0.4);
}

.cd-btn-submit :deep(.q-btn__wrapper) {
  color: #faf5ff !important;
}

.cd-btn-submit :deep(.q-icon) {
  color: #ede9fe !important;
}

.cd-btn-submit:hover :deep(.q-focus-helper) {
  opacity: 0.14 !important;
}
</style>
