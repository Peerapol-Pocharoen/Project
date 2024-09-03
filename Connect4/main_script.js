function muteSound(){
    var icon = document.getElementById("toggle-icon");
    if (icon.src.includes('https://cdn.icon-icons.com/icons2/1933/PNG/512/iconfinder-volume-mute-sound-speaker-audio-4593175_122269.png')){
        icon.src ='https://cdn0.iconfinder.com/data/icons/symbol-duo-common-7/32/audio_active-512.png'
    }
    else {
        icon.src = 'https://cdn.icon-icons.com/icons2/1933/PNG/512/iconfinder-volume-mute-sound-speaker-audio-4593175_122269.png'
    }
}

function moveToPlay() {
    window.location.href = "in_game.html";
}

function moveToHow() {
    window.location.href = "tutorial.html";
}

function moveToSetting() {
    window.location.href = "setting.html";
}
