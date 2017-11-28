<template>
  <div id="wrapper">
    <main>
      <div class="left-side">
        <span class="title">
          Welcome to your new project!
        </span>
        <system-information></system-information>
      </div>
    </main>
  </div>
</template>


<script lang="coffee">
    import SystemInformation from './LandingPage/SystemInformation'

    export default
        default:
            name: 'landing-page'
            components: { SystemInformation }
            methods:
                open: (link) ->
                    @$electron.shell.openExternal(link)
</script>


<style lang="scss">
</style>
