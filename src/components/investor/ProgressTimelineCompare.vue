<template>
  <q-card flat bordered class="ptc-card">
    <div class="ptc-header text-center q-px-md q-pt-lg q-pb-md">
      <div class="text-overline ptc-overline q-mb-xs">Before and after</div>
      <h3 class="text-h6 text-weight-bold ptc-title q-mb-sm">
        Progress over time
      </h3>
      <p class="text-body2 ptc-lead q-mb-none">
        Drag the line from <strong class="text-weight-bold">Before</strong> to
        <strong class="text-weight-bold">After</strong> to see how momentum changes.
      </p>
    </div>

    <div
      class="ptc-chart-wrap"
      @pointerdown="onWrapPointerDown"
    >
      <svg
        ref="svgRef"
        class="ptc-svg"
        viewBox="0 0 900 360"
        xmlns="http://www.w3.org/2000/svg"
        role="img"
        aria-label="Progress over time before and after using the product"
      >
        <!-- Plot background -->
        <rect
          class="ptc-plot-bg"
          x="72"
          y="40"
          width="796"
          height="260"
          rx="12"
        />

        <!-- Grid -->
        <g class="ptc-grid" opacity="0.35">
          <line
            v-for="i in 5"
            :key="'h' + i"
            x1="72"
            :y1="40 + (i - 1) * 65"
            x2="868"
            :y2="40 + (i - 1) * 65"
          />
          <line
            v-for="i in 6"
            :key="'v' + i"
            :x1="72 + (i - 1) * 159.2"
            y1="40"
            :x2="72 + (i - 1) * 159.2"
            y2="300"
          />
        </g>

        <!-- Axes -->
        <line x1="72" y1="300" x2="868" y2="300" class="ptc-axis" />
        <line x1="72" y1="40" x2="72" y2="300" class="ptc-axis" />

        <text x="470" y="348" text-anchor="middle" class="ptc-axis-label">Time</text>
        <text
          x="26"
          y="178"
          text-anchor="middle"
          class="ptc-axis-label"
          transform="rotate(-90 26 178)"
        >
          Progress
        </text>

        <!-- Zone labels -->
        <text x="200" y="64" text-anchor="middle" class="ptc-zone ptc-zone--before">
          Before
        </text>
        <text x="700" y="64" text-anchor="middle" class="ptc-zone ptc-zone--after">
          After
        </text>

        <!-- Curves -->
        <path
          :d="pathBefore"
          fill="none"
          class="ptc-line ptc-line--before"
          :stroke-opacity="beforeOpacity"
          stroke-width="4"
          stroke-linecap="round"
          stroke-linejoin="round"
        />
        <path
          :d="pathAfter"
          fill="none"
          class="ptc-line ptc-line--after"
          :stroke-opacity="afterOpacity"
          stroke-width="4"
          stroke-linecap="round"
          stroke-linejoin="round"
        />

        <!-- Draggable line -->
        <line
          :x1="handleX"
          :x2="handleX"
          y1="36"
          y2="304"
          class="ptc-divider"
          pointer-events="none"
        />
        <rect
          :x="handleX - 14"
          y="0"
          width="28"
          height="360"
          class="ptc-hit"
          @pointerdown.stop.prevent="onHandlePointerDown"
        />
        <g :transform="'translate(' + handleX + ',316)'">
          <rect
            x="-56"
            y="-10"
            width="112"
            height="44"
            rx="12"
            class="ptc-knob-bg"
            @pointerdown.stop.prevent="onHandlePointerDown"
          />
          <text y="18" text-anchor="middle" class="ptc-knob-label">Drag</text>
        </g>
      </svg>
    </div>

    <q-card-section class="q-pt-sm q-pb-lg q-px-md">
      <div class="row q-col-gutter-md items-start">
        <div class="col-12 col-sm-6">
          <div class="ptc-caption ptc-caption--before q-pa-md rounded-borders">
            <div class="text-subtitle2 text-weight-bold q-mb-xs">Before our app</div>
            <p class="text-caption q-mb-none">
              Early gains, then the curve levels off — progress stalls while time keeps moving.
            </p>
          </div>
        </div>
        <div class="col-12 col-sm-6">
          <div class="ptc-caption ptc-caption--after q-pa-md rounded-borders">
            <div class="text-subtitle2 text-weight-bold q-mb-xs">After our app</div>
            <p class="text-caption q-mb-none">
              Progress keeps pace with time: fewer plateaus, more compounding forward motion.
            </p>
          </div>
        </div>
      </div>
    </q-card-section>
  </q-card>
</template>

<script setup>
import { computed, onUnmounted, ref } from 'vue'

const P0 = { x: 72, yTop: 40, yBottom: 300, xMax: 868 }
const plotW = P0.xMax - P0.x
const plotH = P0.yBottom - P0.yTop

function yForProgress (p) {
  return P0.yBottom - p * plotH
}

function buildBeforePath () {
  const n = 48
  let d = ''
  for (let i = 0; i <= n; i++) {
    const t = i / n
    const x = P0.x + t * plotW
    let p
    if (t < 0.34) {
      const u = t / 0.34
      p = 0.1 + 0.62 * (1 - Math.pow(1 - u, 2.2))
    } else {
      p = 0.72 + (t - 0.34) * 0.02
    }
    const y = yForProgress(Math.min(p, 0.78))
    d += (i === 0 ? 'M' : 'L') + ` ${x.toFixed(1)} ${y.toFixed(1)} `
  }
  return d.trim()
}

function buildAfterPath () {
  const n = 48
  let d = ''
  for (let i = 0; i <= n; i++) {
    const t = i / n
    const x = P0.x + t * plotW
    const p = 0.08 + 0.88 * Math.pow(t, 0.88)
    const y = yForProgress(p)
    d += (i === 0 ? 'M' : 'L') + ` ${x.toFixed(1)} ${y.toFixed(1)} `
  }
  return d.trim()
}

const pathBefore = buildBeforePath()
const pathAfter = buildAfterPath()

const blend = ref(0.12)
const svgRef = ref(null)
const dragging = ref(false)
let dragListenersActive = false

const handleX = computed(() => P0.x + blend.value * plotW)

const beforeOpacity = computed(() => 1 - blend.value)
const afterOpacity = computed(() => blend.value)

function clientToBlend (clientX) {
  const el = svgRef.value
  if (!el) return blend.value
  const rect = el.getBoundingClientRect()
  const vb = 900
  const xSvg = ((clientX - rect.left) / rect.width) * vb
  const b = (xSvg - P0.x) / plotW
  return Math.min(1, Math.max(0, b))
}

function setBlend (clientX) {
  blend.value = clientToBlend(clientX)
}

function beginDrag (e) {
  e.preventDefault()
  setBlend(e.clientX)
  if (!dragListenersActive) {
    dragListenersActive = true
    dragging.value = true
    window.addEventListener('pointermove', onPointerMove)
    window.addEventListener('pointerup', endDrag)
    window.addEventListener('pointercancel', endDrag)
  }
}

function onPointerMove (e) {
  if (!dragging.value) return
  setBlend(e.clientX)
}

function endDrag () {
  if (!dragListenersActive) return
  dragListenersActive = false
  dragging.value = false
  window.removeEventListener('pointermove', onPointerMove)
  window.removeEventListener('pointerup', endDrag)
  window.removeEventListener('pointercancel', endDrag)
}

function onHandlePointerDown (e) {
  e.stopPropagation()
  beginDrag(e)
}

function onWrapPointerDown (e) {
  if (e.target.closest?.('.ptc-hit')) return
  beginDrag(e)
}

onUnmounted(() => {
  endDrag()
})
</script>

<style scoped>
.ptc-card {
  width: 100%;
  max-width: 960px;
  margin-left: auto;
  margin-right: auto;
  border-radius: 20px;
  border: 1px solid rgba(196, 181, 253, 0.28);
  background: linear-gradient(
    165deg,
    rgba(30, 27, 75, 0.55) 0%,
    rgba(15, 23, 42, 0.75) 100%
  );
}

.ptc-overline {
  color: #a78bfa;
  letter-spacing: 0.14em;
}

.ptc-title {
  color: #f5f3ff;
}

.ptc-lead {
  color: #c4b5fd;
  max-width: 36rem;
  margin-left: auto;
  margin-right: auto;
  line-height: 1.55;
}

.ptc-chart-wrap {
  position: relative;
  width: 100%;
  cursor: ew-resize;
  user-select: none;
  touch-action: none;
  padding: 0 8px 8px;
}

.ptc-svg {
  display: block;
  width: 100%;
  height: auto;
  max-height: min(520px, 72vh);
}

.ptc-plot-bg {
  fill: rgba(15, 23, 42, 0.45);
  stroke: rgba(167, 139, 250, 0.15);
  stroke-width: 1;
}

.ptc-grid line {
  stroke: rgba(196, 181, 253, 0.12);
  stroke-width: 1;
}

.ptc-axis {
  stroke: rgba(237, 233, 254, 0.35);
  stroke-width: 2;
}

.ptc-axis-label {
  fill: #a78bfa;
  font-size: 14px;
  font-weight: 600;
}

.ptc-zone {
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.ptc-zone--before {
  fill: #fbbf24;
  opacity: 0.9;
}

.ptc-zone--after {
  fill: #4ade80;
  opacity: 0.95;
}

.ptc-line--before {
  stroke: #fbbf24;
}

.ptc-line--after {
  stroke: #4ade80;
}

.ptc-divider {
  stroke: #faf5ff;
  stroke-width: 3;
  stroke-opacity: 0.95;
  filter: drop-shadow(0 0 6px rgba(124, 58, 237, 0.8));
}

.ptc-hit {
  fill: transparent;
  cursor: ew-resize;
}

.ptc-knob-bg {
  fill: rgba(49, 46, 129, 0.92);
  stroke: rgba(196, 181, 253, 0.55);
  stroke-width: 1;
}

.ptc-knob-label {
  fill: #ede9fe;
  font-size: 13px;
  font-weight: 700;
  pointer-events: none;
}

.ptc-caption {
  border: 1px solid rgba(196, 181, 253, 0.2);
}

.ptc-caption--before {
  background: rgba(251, 191, 36, 0.08);
  color: #fde68a;
}

.ptc-caption--before .text-subtitle2 {
  color: #fef3c7;
}

.ptc-caption--after {
  background: rgba(74, 222, 128, 0.08);
  color: #bbf7d0;
}

.ptc-caption--after .text-subtitle2 {
  color: #dcfce7;
}
</style>
