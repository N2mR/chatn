// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
document.addEventListener('turbolinks:load', function() {


    //message function


    //追加していく機能


    $('#new_message').on('submit', function(e){
        e.preventDefault();

        // ajaxを取得してhtmlを形成する
        function buildHTML(message) {
            var content = message.content ? `${ message.content }` : "";
            var date = message.date ? `${ message.date }` : "";
            var id = message.id ? `${ message.id }` : "";
            var html = `<div class="col-xs-offset-8 col-sx-4">
                            <div id="user message-${ id }">
                                    <p>${ content }</p>
                                    <p>${ date }</p>
                            </div>
                        </div>`
          return html;
        }

        const content = document.getElementById('content');
        if(content.value !== null){
            // content を message に代入する
            var message = content.value;
            // 現在のURLを取得して url に代入する
            //var url = "http://localhost:3000/messages";
            // データをajax形式でpostする
            $.ajax({  
                url: "http://localhost:3000/messages",
                type: 'POST',
                data: message,
                dataType: 'json',
                processData: false,
                contentType: false
            })
            .done(function(data){
                var html = buildHTML(data);
                $('#message_content').append(html);
                $('#content').val(''); //input内のメッセージを消しています。
            })
            .fail(function(data){
                alert('エラーが発生したためメッセージは送信できませんでした。');
            })
        }
        
        
    })


    //

    function scrollButtom(){
        chat_window.scroll(0, 10000000);
    };
    const chat_window = document.getElementById('chat_window');
    if(chat_window !== null){
        scrollButtom();
    }

    // const send_message = document.getElementById('send_message');

    // if(send_message !== null){
    //     send_message.addEventListener('click', function(){
    //     const content = document.getElementById('content');
    //         if(content.value !== null){

    //             //content の value
    //             let content_value = content.value;
    //             //送信日時
            
    //             //HTMLの生成
    //             $('#chat_window').append(`<div class="col-xs-offset-8 col-sx-4">
    //                                         <div id="user">
    //                                             <p>${content_value}</p>
    //                                             <p>time</p>
    //                                         </div>
    //                                       </div>`)
    //             scrollButtom();
    //             content.value = ''
    //         }
    //     });
    //  };







});


