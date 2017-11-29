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
    cursor: default;
}

#app {
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
