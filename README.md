# vimfiles

Requires some setup, currenlty done by Ansible.

For a set of plugins that makes a lot of sense, see <https://www.youtube.com/watch?v=wlR5gYd6um0>.

## Snippets

For a cheap snippet, `,sfoo` will insert foo.txt at the cursor position from normal mode:

    nnoremap ,sfoo :-1read $HOME/.vim/snips/foo.txt<CR>

where `,s` stands for "snippet".
