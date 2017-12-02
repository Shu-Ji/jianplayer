<template lang="pug">
#main.show-fullscreen
    Mpv.show-fullscreen(:onReady="handleMpvReady" :onPropertyChange="handlePropertyChange")
    #mask.show-fullscreen(@click="oneClick")
        button(type="button" @click.stop.prevent="togglePause") 播放
        input(type="range" min="0" :max="state.duration" :value="state['time-pos']")
        pre {{ state }}
    #mask-landing.flex.show-fullscreen(v-if="!is_file_loaded")
        .flex-1
        .flex-none.text-center.logo-wrapper
            .logo 简
        .flex-1
</template>


<script lang="coffee" src="./landing-page.coffee"></script>
<style lang="scss" src="./landing-page.scss"></style>
