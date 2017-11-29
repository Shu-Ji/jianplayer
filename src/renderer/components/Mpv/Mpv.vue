<template lang="pug">
embed#player(:type="PLUGIN_MIME_TYPE")
</template>


<script lang="coffee" src="./mpv.coffee"></script>


<style lang="scss">
#player {
    display: block;
    height: 100%;
    width: 100%;
    background: #ccc;
}
</style>
