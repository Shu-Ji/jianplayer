<template lang="pug">
.main
    Mpv(:onReady="handleMpvReady" :onPropertyChange="handlePropertyChange")
    #mask(@click="togglePause")
        button(type="button" @click="openFile") 打开
        button(type="button" @click="togglePause") 播放
        input(type="range" min="0" :max="state.duration" :value="state['time-pos']")
        pre {{ state }}
</template>


<script lang="coffee" src="./landing-page.coffee"></script>


<style lang="scss">
.main {
    width: 100%;
    height: 100%;
    position: fixed;
}
#mask {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
}
</style>
