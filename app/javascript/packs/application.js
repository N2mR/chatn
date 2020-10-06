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



// window.addEventListener('load', (event) => {
//     $('#send_message').removeAttr("disabled");
// });
document.addEventListener('turbolinks:load', function() {

    // message func

    const send_message = document.getElementById('send_message');
    if(send_message !== null){
        send_message.addEventListener('click', function(){
            let content = document.getElementById('content');
            if(content.value !== null){
                let createHTML = `<div class="col-xs-offset-8 col-sx-4">
                                    <div id="user message-<%= @message.id %>">
                                            <p>${content.value}</p>
                                            <p>${time()}</p>
                                    </div>
                                  </div>`;
                $('#chat_window').append(createHTML);
            };
        });
    }


    //追加していく機能


    //メッセージボックスを一番下にスクロールした状態にする

    function scrollButtom(){
        chat_window.scroll(0, 10000000);
    };

    const chat_window = document.getElementById('chat_window');
    if(chat_window !== null){
        scrollButtom();
    }

    // get time func
    function time(){
        DD = new Date();
        Year = DD.getFullYear();
        Month = DD.getMonth() + 1;
        Day = DD.getDate();
        return `${Year}-${Month}-${Day}`
    };
    

    




});


