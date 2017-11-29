import {remote} from 'electron'
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

        components: { Mpv }

        mounted: ->
            setTimeout =>
                @openFile()
            , 300

            document.addEventListener('keydown', @handleKeyDown, false)

        beforeDestroy: ->
            document.removeEventListener('keydown', @handleKeyDown, false)

        methods:

            handleKeyDown: (e) ->
                e.preventDefault()
                if (e.key == 'f') or (e.key == 'Escape' and @state.fullscreen)
                    @toggleFullscreen()
                else if @state.duration
                    @mpv.keypress(e)

            handleMpvReady: (@mpv) ->
                observe = @mpv.observe.bind(@mpv)
                ["pause", "time-pos", "duration", "eof-reached"].forEach(observe)

            handlePropertyChange: (name, value) ->
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
