    /*
        gallery.js for schwarz-weiss.net
        --------------------------------
        Version with description
        --------------------------------

        generate:
        uglifyjs gallery.js -o gallery-min.js
    */

    $(document).ready(function(){
        gallery.init();

        $(window).bind('hashchange', function(){
            gallery.hashchange();
        });
    });

    var gallery =  {

        config: {

            pos: {
                x: {
                    start: 0,
                    distance: 0
                },
                y: {
                    start: 0,
                    distance: 0
                }
            },
            images: [],
            current: false,
            touchme: false,
            pointme: false,
            wrapper_top: 0,
            wrapper_left: 0,
            direction: false,
            view_move: false,
            timer: 0,
            loading : [],
            dpl_navi: false,
            view_tools: false,
            view_info: false,
            anim_speed: 200,
            info_url: false,
            ef: '!',
            hl: 2,
            loader: '../gfx/loader.gif',
            resizerun: false,
            isSmallDevice: false,
            smallDeviceMax: 500,
            testing: false
        },

        data: [],
        map: {},

        init: function() {
            this.config.touchme = 'ontouchstart' in window;
            this.config.pointme = window.navigator.msPointerEnabled? true : false;
            this.config.isSmallDevice = this.detectSmallDevice();

            this.init_thumbs();
            this.bind_view_events();
            this.resizefix();

            /* no dragging for windows mobile without these styles */
            if(this.config.pointme) {
                $('#viewimage-wrapper-list').css({
                    '-ms-touch-action': 'none',
                    '-ms-user-select': 'none',
                    'touch-action': 'none',
                    'user-select': 'none'
                });
            }

            if(self.location.hash) {
                this.dpl_view_image();
            }

            if(typeof escaped_fragment !== "undefined" && escaped_fragment) {
                this.dpl_escaped_fragment();
            }
        },

        /**
         * detect small viewport to load lowSrc images
         * @author      kgde@wendenburg.de
         * @return      {boolean}
         */
        detectSmallDevice: function() {
            return (
                $(window).width() < this.config.smallDeviceMax ||
                $(window).height() < this.config.smallDeviceMax
            ) ? true : false;
        },

        hashchange: function() {
            var hash =  self.location.hash.substr(this.config.hl);
            if(hash && hash !== this.config.current) {
                this.dpl_view_image();
            } else if(!hash) {
                this.dpl_thumb_list();
            }
        },

        /**
         * initialize thumbnail list and collect data
         * @author      kgde@wendenburg.de
         * @return      {void}
         */
        init_thumbs: function() {

            var obj =  this;
            $('li', '.gallery-thumblist').each(function() {
                var $this   =  $(this);
                var $a      =  $('a:first', $this);
                var $img    =  $('img:first', $this);
                var href    =  $a.attr('href');
                var src     =  $img.attr('src');
                var view    =  obj.config.isSmallDevice ? $img.data('lowsrc') : $img.data('fullsrc');
                var key     =  $img.data('key') || src.substr(kstart).replace('.jpg', '');
                var kstart  =  (src.lastIndexOf('/') > 0)? src.lastIndexOf('/') +1 : 0;
                var idx     =  obj.data.length;

                $a.data('key', key);
                $a.data('idx', idx);
                $a.bind('click', function(e){
                    e.preventDefault();
                    obj.config.current =  $(this).data('key');
                    self.location.hash =  obj.config.ef + $(this).data('key'); //escape fragments
                    obj.dpl_view_image();
                });

                var tmp =  {
                    src: src,
                    href: href,
                    view: view,
                    key: key,
                    content: false
                }
                obj.data.push(tmp);
                obj.map[key] =  idx;
            });
            // testout
            this.db('init_thumbs', this.data);
        },

        /**
         * bind events to view image
         * @author      kgde@wendenburg.de
         * @return      {void}
         */
        bind_view_events: function() {

            var obj =  this;

            $('img', '#viewimage-wrapper-list').each(function() {

                // mobile events android, ios...
                if(obj.config.touchme) {
                    this.addEventListener('touchstart', obj, false);
                    this.addEventListener('touchmove', obj, false);
                    this.addEventListener('touchend', obj, false);
                } else if(obj.config.pointme) {
                    this.addEventListener('MSPointerDown', obj, false);
                    this.addEventListener('MSPointerMove', obj, false);
                    this.addEventListener('MSPointerUp', obj, false);
                }

                if(this.addEventListener) {
                    this.addEventListener('mousedown', obj, false);
                    this.addEventListener('mouseup', obj, false);
                    this.addEventListener('mousemove', obj, false);
                    this.addEventListener('mouseout', obj, false);
                } else {
                    this.onmousedown    =  function(e){var ev = e || window.event; obj.handleEvent(ev)};
                    this.onmouseup      =  function(e){var ev = e || window.event; obj.handleEvent(ev)};
                    this.onmousemove    =  function(e){var ev = e || window.event; obj.handleEvent(ev)};
                    this.onmouseout     =  function(e){var ev = e || window.event; obj.handleEvent(ev)};
                }
            });
        },

        /**
         * global event handler
         * @author      kgde@wendenburg.de
         */
        handleEvent: function(e) {

            var obj         =  this;
            var target      =  e.target || e.srcElement;
            var $img        =  $('img', '#viewimage-wrapper-list').get(1);

            if(target === $img) {
                return obj.handle_viewimg(e);
            }
        },

        handle_viewimg: function(e) {
            switch(e.type) {
                case 'touchstart':
                    e.preventDefault();
                    var touch                   =  e.touches[0] || e.changedTouches[0];
                    this.config.pos.x.start     =  touch.pageX;
                    this.config.pos.y.start     =  touch.pageY;
                    this.reset_positions();
                    break;
                case 'touchmove':
                    if(this.config.view_move) {
                        e.preventDefault();
                        var touch   =  e.touches[0] || e.changedTouches[0];
                        var xpos    =  touch.pageX;
                        var ypos    =  touch.pageY;
                        this.calculate_direction(xpos, ypos);
                    }
                    break;
                case 'touchend':
                    if(this.config.view_move) {
                        e.preventDefault();
                        this.config.view_move   =  false;
                        this.handle_move();
                    }
                    break;
                case 'MSPointerDown':
                case 'mousedown':
                    if(e.preventDefault) {
                        e.preventDefault();
                    } else {
                        e.returnValue = false;
                    }
                    this.config.pos.x.start     =  e.clientX;
                    this.config.pos.y.start     =  e.clientY;
                    this.reset_positions();
                    break;
                case 'MSPointerMove':
                case 'mousemove':
                    if(this.config.view_move) {
                        var xpos =  e.clientX;
                        var ypos =  e.clientY;
                        this.calculate_direction(xpos, ypos);
                    }
                    break;
                case 'MSPointerUp':
                case 'mouseup':
                case 'mouseout':
                    if(this.config.view_move) {
                        this.config.view_move   =  false;
                        this.handle_move();
                    }
                    break;
            }
            return false;
        },

        reset_positions: function() {
            this.config.timer           =  new Date().getTime();
            this.config.view_move       =  true;
            this.config.pos.x.distance  =  0;
            this.config.pos.y.distance  =  0;
            this.config.wrapper_top     =  parseInt($('#gallery-wrapper').css('top'));
            this.config.wrapper_left    =  parseInt($('#viewimage-wrapper-list').css('left'));
        },

        calculate_direction: function(xpos, ypos) {
            this.config.pos.x.distance  =  xpos -this.config.pos.x.start;
            this.config.pos.y.distance  =  ypos -this.config.pos.y.start;
            this.config.direction       =  (Math.abs(this.config.pos.y.distance) > Math.abs(this.config.pos.x.distance))? 'v' : 'h';

            if(this.config.direction === 'v') {
                // move content with the mouse
                var next_y_pos =  (this.config.wrapper_top + this.config.pos.y.distance) + 'px';
                $('#gallery-wrapper').css('top', next_y_pos);
                $('#viewimage-wrapper-list').css('left', '-100%');
                // reset x distance - we move in the y-axis only
                this.config.pos.x.distance = 0;
            } else if(this.config.direction === 'h') {
                // move image with the mouse
                var next_x_pos =  (this.config.wrapper_left + this.config.pos.x.distance) + 'px';
                $('#viewimage-wrapper-list').css('left', next_x_pos);
                $('#gallery-wrapper').css('top', '-100%');
                // reset y distance - we move in the x-axis only
                this.config.pos.y.distance = 0;
            }
        },

        /**
         * after mouseup/touchend decide what to do
         * continue with the move or reset
         * @author  kgde@wendenburg.de
         * @return  {void}
         */
        handle_move: function() {

            if(this.config.pos.y.distance > 100) {
                this.dpl_thumb_list();
            } else if(this.config.pos.y.distance < -100) {
                //this.dpl_content();
                this.dpl_view_image();
                this.display_info();
            } else if(this.config.pos.y.distance !== 0) {
                this.dpl_view_image();
            }

            if(this.config.pos.x.distance > 100) {
                this.dpl_first_view();
            } else if(this.config.pos.x.distance < -100) {
                this.dpl_last_view();
            } else if(this.config.pos.x.distance !== 0)  {
                this.dpl_center_view();
            }

            // reset direction
            this.config.direction = false;
            // detect a click instead of a move
            this.get_click();
        },

        /**
         * just a small move within a short time?
         * find out if we deal with a click
         * @author  kgde@wendenburg.de
         * @return  {void}
         */
        get_click: function() {
            // move out of click-range
            if(Math.abs(this.config.pos.x.distance) > 20 || Math.abs(this.config.pos.y.distance) > 20) {
                return false;
            }
            // down and up within delay
            var now =  new Date().getTime();
            if(now - this.config.timer < 200) {
                this.display_tools();
            }
            this.config.timer =  0;
        },

        /**
         * find out what images must be loaded
         * reset description and initialize loading
         * @author  kgde@wendenburg.de
         * @param   {string} modus curr, prev or next
         * @return  {void}
         */
        get_current_images: function(mod) {

            var obj =  this;
            var key =  self.location.hash.substr(this.config.hl) || this.config.current;
            var idx =  (typeof this.map[ key ] === "undefined")? 0 : this.map[ key ];

            var img =  {};
                img['curr'] =  idx;
                img['next'] =  (idx +1 < this.data.length)? idx +1 : 0;
                img['prev'] =  (idx -1 > -1)?                idx -1 : this.data.length -1;

            var $img0 =  $('img', '#viewimage-wrapper-list').eq(0);
            var $img1 =  $('img', '#viewimage-wrapper-list').eq(1);
            var $img2 =  $('img', '#viewimage-wrapper-list').eq(2);

            switch(mod) {
                case 'prev':
                    //this.load($img0, img['prev']);
                    this.load($img2, img['next']);
                    break;
                case 'next':
                    //this.load($img2, img['next']);
                    this.load($img0, img['prev']);
                    break;
                default:
                    // all images must be loaded
                    this.load($img1, img['curr']);
                    this.load($img0, img['prev']);
                    this.load($img2, img['next']);
            }


           this.load_content();
        },

        /**
         * modify image source
         * @author  kgde@wendenburg.de
         * @param   {object} jquery image object
         * @param   {number} index data array
         * @return  {void}
         */
        load: function($img, idx) {
            $img.attr('src', this.config.loader);
            $img.attr('src', this.data[ idx ].view).data('idx', idx).data('key', this.data[ idx ].key);
        },

        reset_current: function() {
            self.location.hash  = "";
            this.config.current =  false;
            $('#thumblist-wrapper').scrollTop(0);
        },

        toggle_navi: function() {
            this.config.dpl_navi =  arguments.length? arguments[0] : (this.config.dpl_navi? false : true);
            if(this.config.dpl_navi) {
                $('#gallery-wrapper').addClass('dpl-navi');
            } else {
                $('#gallery-wrapper').removeClass('dpl-navi');
            }
        },

        dpl_thumb_list: function() {
            this.reset_current();
            $('#gallery-wrapper').animate({'top': 0}, this.config.anim_speed);
        },

        dpl_view_image: function() {
            this.toggle_navi(false);
            this.get_current_images('curr');
            $('#gallery-wrapper').animate({'top':'-100%'}, this.config.anim_speed);
        },

        dpl_first_view: function() {
            var obj =  this;
            $('#viewimage-wrapper-list').animate({'left': 0}, this.config.anim_speed, function(){
                var $move_li =  $('li:last', '#viewimage-wrapper-list');
                $('#viewimage-wrapper-list').prepend( $move_li ).css('left', '-100%');
                obj.set_current('next');
            });
        },

        dpl_center_view: function() {
            $('#viewimage-wrapper-list').animate({'left': '-100%'}, this.config.anim_speed);
        },

        dpl_last_view: function() {
            var obj =  this;
            $('#viewimage-wrapper-list').animate({'left': '-200%'}, this.config.anim_speed, function(){
                var $move_li    =  $('li:first', '#viewimage-wrapper-list');
                $('#viewimage-wrapper-list').append( $move_li ).css('left', '-100%');
                obj.set_current('prev');
            });
        },

        set_current: function(mod) {
            $img                =  $('img', '#viewimage-wrapper-list').eq(1);
            this.config.current =  $img.data('key');
            self.location.hash  =  this.config.ef + $img.data('key');
            this.get_current_images(mod);
        },

        dpl_image_src: function() {
            var key =  self.location.hash.substr(this.config.hl) || this.config.current;
            var idx =  (typeof this.map[ key ] === "undefined")? 0 : this.map[ key ];
            self.location.href =  this.data[ idx ].view;
            //self.location.href =  $('img', '#viewimage-wrapper-list').eq(1).attr('src');
        },

        dpl_escaped_fragment: function() {
            this.config.current =  escaped_fragment;
            $('#gallery-wrapper').animate({'top':'-100%'}, this.config.anim_speed);
            this.get_current_images();
            this.display_info();
        },

        load_content: function() {
            var key         =  self.location.hash.substr(this.config.hl) || this.config.current;
            var $info       =  $('#image-info').html('');
            var $content    =  $('#info-' + key).html();

            $info.html($content);

            if(this.config.info_url) {
                //load info
            }
        },

        display_info_container: function(key) {
            $('.image-description').css('display', 'none');
            $('#info-' + key).css('display', 'block');
        },

        display_tools: function() {
            this.view_tools =  arguments.length? arguments[0] : (this.view_tools? false : true);
            var dpl =  this.view_tools? 'block' : 'none';
            $('#image-tools').css('display', dpl);

            if(!this.view_tools) {
                this.display_info(false);
            }
        },

        display_info: function() {
            this.view_info =  arguments.length? arguments[0] : (this.view_info? false : true);
            var dpl =  this.view_info? 'block' : 'none';
            $('.image-info-wrapper').css('display', dpl);
        },

        /**
         * dislike jquery.contains, it is buggy...
         * check if container contains containee
         *
         * @author  kgde@wendenburg.de
         *
         * @params  {object} container as DOM reference
         * @param   {object} containee as DOM reference
         * @return  {boolean}
         */
        isinside: function (container, containee) {
            if (typeof container === "undefined") {
                return false;
            }
            if (window.Node && Node.prototype && !Node.prototype.contains) {
                Node.prototype.contains = function (arg) {
                    return !!(this.compareDocumentPosition(arg) & 16);
                };
            }
            return container.contains(containee);
        },

        /**
         * call exec_resize if resize was detected
         * @author  jw
         * @return  {void}
         */
        resizefix: function() {
            var obj =  this;
            $(window).bind('resize', function() {
                clearTimeout(obj.config.resizerun);
                obj.config.resizerun = setTimeout(function() {
                    obj.dpl_center_view();
                }, 200);
            });
        },

        db: function() {

            if(!this.config.testing) {
                return false;
            }

            try {
                var i, item;
                for(i=0;item=arguments[i];i+=1) {
                    console.log(item);
                }
            } catch(err){}
        }
    };

