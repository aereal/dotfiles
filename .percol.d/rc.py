percol.import_keymap({
    "C-h": lambda percol: percol.command.delete_backward_char(),
    "C-d": lambda percol: percol.command.delete_forward_char(),
    "C-k": lambda percol: percol.command.kill_end_of_line(),
    "C-a": lambda percol: percol.command.beginning_of_line(),
    "C-e": lambda percol: percol.command.end_of_line(),
    "C-b": lambda percol: percol.command.backward_char(),
    "C-f": lambda percol: percol.command.forward_char(),
    "C-n": lambda percol: percol.command.select_next(),
    "C-p": lambda percol: percol.command.select_previous(),
    "C-m": lambda percol: percol.finish(),
    "C-j": lambda percol: percol.finish(),
    "C-g": lambda percol: percol.cancel(),
    "M-x": lambda percol: percol.command.toggle_mark_and_next(),
})

percol.view.PROMPT = ur"<yellow>X | _ | X</yellow> > %q"
