<template lang="pug">
  #app
    router-view
</template>


<script lang="coffee">
export default
    name: 'jianplayer'
    mounted: ->
        document.title = @$t('main.title')
</script>


<style lang="scss">
html, body {
    padding: 0;
    margin: 0;
}

body, #app {
    min-height: 540px;
    min-width: 960px;
    box-sizing: border-box;
    cursor: default;
}

#app {
    height: 100%;
    width: 100%;

    padding: 10px;
    //-webkit-user-select: none;
    //-webkit-app-region: drag;
}

input[type="submit"],
input[type="reset"],
input[type="button"],
input[type="text"],
button,
textarea {
    //-webkit-app-region: no-drag;
}
</style>
