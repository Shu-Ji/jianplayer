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
html {
}
</style>
