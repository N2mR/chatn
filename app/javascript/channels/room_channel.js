import consumer from "./consumer"

document.addEventListener("turbolinks:load", function(){
  const chatChannel = consumer.subscriptions.create("RoomChannel", {

    connected() {
      // Called when the subscription is ready for use on the server
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received: function(data) {
      var room = document.getElementById('room');
      let chat_window = document.getElementById('chat_window');
      if(room){
        let createHTML = `<div class="message_left">
                            <div class="other_users_message message">
                              <div>
                                <p>${data['message']}</p>
                                <p>${data['created_at']}</p>
                              </div>
                            </div>
                          </div>`;
        $('#chat_window').append(createHTML);
        scrollBottom(chat_window);
        createHTML = '';
      }
      //return alert(data['message']);
    },
  
    speak: function(data) {
      return this.perform('speak',{
        data
      })
    },

    cookies: function(){
      return this.perform('cookies')
    },

    loadUserData: function(){
      return this.perform('subscribed')
    }

  });

  //チャットウィンドウ
  let window = document.getElementById('chat_window');
  //トークボタン
  const talk_button = document.querySelector('.talk_button');

  //トークのクリック時、room_channel.rbのsubscribedを実行
  if(talk_button){
    talk_button.addEventListener('click', function(){
      chatChannel.loadUserData();
    });
  }


  //一番下までスクロール
  function scrollBottom(object){
    object.scroll(0,10000000)
  };




  //チャットルームのdata属性からユーザーのデータを取得
  function getRoomData(message){
    var current_user_id = $('#room').data('current_user')
    var other_user_id = $('#room').data('other_user')
    var room_id = $('#room').data('room_id')
    var data = { current_user_id: current_user_id, other_user_id: other_user_id, room_id: room_id, message: message }
    return data
  }

  chatChannel.cookies();

  
  //数字が一桁であれば０で埋める
  var toDoubleDigits = function(num) {
    num += "";
    if (num.length === 1) {
      num = "0" + num;
    }
   return num;
  } 
  

  //現在時刻を取得
  
  function get_current_time(){
    
    var date = new Date();
    var year = date.getFullYear();
    var month = toDoubleDigits(date.getMonth() + 1);
    var day = toDoubleDigits(date.getDate());
    var hour = toDoubleDigits(date.getHours());
    var minute = toDoubleDigits(date.getMinutes());
    return `${year}/${month}/${day} ${hour}:${minute}`;
  };
  

  // //メッセージの送信・自分のルームにメッセージを非同期で追加
  
  let talk_room = document.querySelector('.talk_room');
  if(talk_room != null){
    var send_message_form = document.getElementById('send_message_form');
    var send_message_btn = document.getElementById('send_message_btn');
    send_message_btn.addEventListener('click', function(){
      var content = send_message_form.value;
      if(1 <= content.length　&& content.length < 140){
        var createHTML = `<div class="message_right">
                          <div class="users_message message">
                            <div>
                                <p>${content}</p>
                                <p>${get_current_time()}</p>
                            </div>
                          </div>
                        </div>`
      $('#chat_window').append(createHTML);
      let chat_window = document.getElementById('chat_window');
      scrollBottom(chat_window);
      let room_data = getRoomData(content);
      chatChannel.speak(room_data);
      send_message_form.value = '';
      createHTML = '';
      }else if(content.length >= 140){
        send_message_form.value = '';
      }
    })
  }
})