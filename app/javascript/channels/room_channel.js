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
      if(room){
        let createHTML = `<div class="other_users_message message col-sm-offset-1">
                            <div>
                              <p>${data['message']}</p>
                              <p>${data['created_at']}</p>
                            </div>
                          </div>`;
        $('#chat_window').append(createHTML);
        scrollBottom(chat_window);
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

  //チャットウィンドウを一番下までスクロールする
  const chat_window = document.getElementById('chat_window');
  const talk_button = document.querySelector('.talk_button');

  if(talk_button){
    talk_button.addEventListener('click', function(){
      chatChannel.loadUserData();
    });
  }

  function reload(){
    if(window.name != 'loaded'){
        window.location.reload()
        window.name = 'loaded';
    }else if(window.name == 'loaded'){
        window.location.reload()
        window.name = '';
    }
  }

document.addEventListener("turbolinks:load", function(){
    reload();
})
  function scrollBottom(object){
    object.scroll(0,10000000)
  };


  // let getRoomData = {
  //   getCurrentUser: function(){
  //     let current_user_id = $('#room').data('current_user')
  //     return current_user_id
  //   },
  //   getOtherUser: function(){
  //     let other_user_id = $('#room').data('other_user')
  //     return other_user_id
  //   },
  //   getRoomId: function(){
  //     let room_id = $('#room').data('room_id')
  //     return room_id
  //   }
  // };

    function getRoomData(message){
      var current_user_id = $('#room').data('current_user')
      var other_user_id = $('#room').data('other_user')
      var room_id = $('#room').data('room_id')
      var data = { current_user_id: current_user_id, other_user_id: other_user_id, room_id: room_id, message: message }
      return data
    }

  chatChannel.cookies();

  function get_current_time(){
    var DD = new Date();
    var Year = DD.getFullYear();
    var Month = DD.getMonth() + 1;
    var Day = DD.getDate();
    var Hour = DD.getHours();
    var Minutes = DD.getMinutes();
    return `${Year}-${Month}-${Day}-${Hour}:${Minutes}`
  };
  

  //
  $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
    if (event.keyCode === 13) {
      var content = event.target.value;
      var createHTML = `<div class="other_users_message message col-sm-offset-8 col-sm-4">
                          <div id="message-">
                                  <p>${content}</p>
                                  <p>${get_current_time()}</p>
                          </div>
                        </div>`
      $('#chat_window').append(createHTML);
      scrollBottom(chat_window);
      chatChannel.speak(getRoomData(content));
      event.target.value = '';
      // return event.preventDefault();
    }
  });

  // if($('#logged_in').data('logged_in')){
  //   var user_id = $('#logged_in').data('logged_in')
  //   chatChannel.cookies(user_id)
  // };
})