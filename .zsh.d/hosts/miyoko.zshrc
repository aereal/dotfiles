case $MULTIPLEXOR in
  tmux)
    if [ $TMUX ]; then
      tmux set-option -g escape '^T'
    else
      tmux
    fi
    ;;
  screen)
    if [ $STY ]; then
      screen -X eval "escape ^t^t"
    else
      screen -rx || screen -D -RR -U
    fi
    ;;
esac
