// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

//= require rails-ujs
//= require jquery
//= require activestorage
//= require bootstrap #追記
//= require turbolinks
//= require_tree .


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)



document.addEventListener('turbolinks:load', function() {


    //navigation
    
    if(document.querySelector('.btn-menu') != null){
        const btn = document.querySelector('.btn-menu');
        const nav = document.querySelector('nav');
        btn.addEventListener('click', () => {
            nav.classList.toggle('open-menu')
            if (btn.innerHTML === 'menu') {
                btn.innerHTML = '×';
            } else {
                btn.innerHTML = 'menu';
            }
        });
    }


    //メッセージボックスを一番下にスクロールした状態にする

    function scrollButtom(){
        chat_window.scroll(0, 10000000);
    };

    const chat_window = document.getElementById('chat_window');
    if(chat_window !== null){
        scrollButtom();
    }

    //画面サイズに応じて表示するメッセージの長さを調節する
    let room_data_message = document.querySelector('.room_data_message');
    if(room_data_message != null){
        $('.room_data_message').css('overflow', 'hidden');
    }

});


