import { remote } from 'electron'
import Vue from 'vue'

import Mpv from '../Mpv/Mpv.vue'


export default
    default:
        name: 'landing-page'

        data: ->
            state:
                pause: true
                'time-pos': 0
                duration: 0
                fullscreen: false
                volume: 70

            # handle click and dblclick
            one_click:
                clicks: 0
                delay: 250
                timer: null

        components: { Mpv }

        mounted: ->
            setTimeout =>
                @openFile()
            , 300

            document.addEventListener('keydown', @handleKeyDown, false)

        beforeDestroy: ->
            document.removeEventListener('keydown', @handleKeyDown, false)

        methods:

            oneClick: (e) ->
                @one_click.clicks += 1
                # in ${delay} milliseconds, if clicked once then single-click
                if @one_click.clicks == 1
                    @one_click.timer = setTimeout =>
                        @togglePause()
                        @one_click.clicks = 0
                    , @one_click.delay
                # else if clicked more than once(see 2, 3, ... times) then
                # double-click
                else
                    clearTimeout(@one_click.timer)
                    @toggleFullscreen()
                    @one_click.clicks = 0

            handleKeyDown: (e) ->
                e.preventDefault()
                key = e.key

                # the default key bindings of mpv
                # https://raw.githubusercontent.com/mpv-player/mpv/master/etc/input.conf
                switch key
                    when ' '
                        @togglePause()
                    when 'Enter'
                        @toggleFullscreen()
                    when 'ArrowLeft'
                        @seek(-5)
                    when 'ArrowRight'
                        @seek(5)
                    when 'ArrowUp'
                        @addVolume(2)
                    when 'ArrowDown'
                        @addVolume(-2)
                    else
                        console.log('Keypressed:', key)

            handleMpvReady: (@mpv) ->
                observe = @mpv.observe.bind(@mpv)
                [   "pause", "time-pos", "duration",
                    "eof-reached",
                    'volume',
                ].forEach(observe)

            handlePropertyChange: (name, value) ->
                if name in ['volume', ]
                    return

                if name != 'time-pos'
                    console.log name, value

                if name == 'time-pos' and @seeking
                    return
                else if name == 'eof-reached' and value
                    @mpv.setProperty('time-pos', 0)
                else
                    @state[name] = value

                # auto play
                if name == 'duration'
                    @mpv.setProperty('pause', false)
                    @mpv.setProperty('volume', @state.volume)

            openFile: (e) ->
                items = remote.dialog.showOpenDialog({
                    filters: [
                        {name: "Videos", extensions: ['mkv', 'mp4', 'mov', 'avi']},
                        {name: "All files", extensions: ['*']},
                    ]
                })

                if items
                    @mpv.command('loadfile', items[0])

            togglePause: ->
                if @state.duration
                    @mpv.setProperty('pause', not @state.pause)

            toggleFullscreen: ->
                if @state.fullscreen
                    document.webkitExitFullscreen()
                else
                    document.querySelector('#main').webkitRequestFullscreen()
                @state.fullscreen = not @state.fullscreen

            seek: (num) ->
                @mpv.command('seek', num)

            addVolume: (num) ->
                new_volume = @state.volume + num
                new_volume = Math.max(new_volume, 0)
                @state.volume = Math.min(new_volume, 100)
                @mpv.setProperty('volume', @state.volume)
