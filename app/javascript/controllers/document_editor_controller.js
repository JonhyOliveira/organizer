import { Controller } from "@hotwired/stimulus"
import { Editor } from "@tiptap"
import { Dropcursor, UndoRedo, Placeholder } from '@tiptap/extensions'
import Document from '@tiptap/document'
import Paragraph from '@tiptap/paragraph'
import Text from '@tiptap/text'
import Image from '@tiptap/image'
import Heading from '@tiptap/heading'
import { ListKit } from '@tiptap/listkit'
import { TextStyleKit } from "@tiptap/listtextstyle"
import DragHandle from '@tiptap/draghandle'

// Connects to data-controller="document-editor"
export default class extends Controller {
  static targets = [ "editor", "content" ]
  static values = { editable: Boolean }

  connect() {
    console.debug("hasEditorTarget", this.hasEditorTarget)
    console.debug("hasContentTarget", this.hasContentTarget, this.contentTarget.value)

    try {
      const that = this

      this.editor = new Editor({
        onUpdate({ editor }) {
          // Update the content target with the current editor content
          const oldContent = that.contentTarget.value
          const newContent = JSON.stringify(editor.getJSON())
          if (newContent != oldContent) {
            that.contentTarget.value = newContent
            console.debug("Editor content updated")
            that.dispatch("update", { detail: { content: that.contentTarget.value } })
          }
        },
        element: this.editorTarget,
        extensions: [
          UndoRedo.configure({ depth: 10 }),
          DragHandle.configure({
            render: () => {
              const element = document.createElement('span')
              element.classList.add('drag-handle')
              element.style.visibility = "hidden"
              element.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" /></svg>'
              return element
            }
          }),
          Document,
          Paragraph,
          Text,
          Image,
          ListKit,
          Dropcursor.configure({ class: "drop-cursor" }),
          Heading.configure({
            levels: [1, 2, 3],
          }),
          TextStyleKit,
          Placeholder.configure({
            placeholder: "Enter text ...",
            emptyNodeClass: "is-node-empty"
          })
        ],
        editable: this.editableValue || false,
      })

      this.editor.commands.setContent(this.contentTarget.value ? JSON.parse(this.contentTarget.value) : undefined)

      console.debug("Editor initialized", this.editor)

    } catch (error) {
      console.error("Error initializing Tiptap editor:", error)
    }
    // this.quill.setContents(this.contentTarget.value ? JSON.parse(this.contentTarget.value) : [])
  }
}
