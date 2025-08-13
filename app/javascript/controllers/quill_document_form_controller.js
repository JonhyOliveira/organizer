import { Controller } from "@hotwired/stimulus"
import "quill"

const toolbarOptions = [
  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
  ['blockquote', 'code-block'],
  ['link', 'image', 'video', 'formula'],

  [{ 'list': 'ordered'}, { 'list': 'bullet' }, { 'list': 'check' }],
  [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
  [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
  [{ 'direction': 'rtl' }],                         // text direction

  [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
  [{ 'font': [] }],
  [{ 'align': [] }],

  ['clean']                                         // remove formatting button
];

// Connects to data-controller="quill-document-form"
export default class extends Controller {
  static targets = [ "editor", "content", "contentHtml" ]

  connect() {
    console.debug(this)
    console.debug("hasEditorTarget", this.hasEditorTarget)
    console.debug("hasContentTarget", this.hasContentTarget)
    console.debug("hasContentHtmlTarget", this.hasContentHtmlTarget)

    this.quill = new Quill(this.editorTarget, {
      theme: "snow",
      modules: {
        toolbar: toolbarOptions
      }
    })

    const that = this
    this.quill.on('text-change', () => that.encode())
    that.decode()
  }

  encode() {
    const ops = this.quill.getContents().ops
    const html = this.quill.getSemanticHTML()

    this.contentTarget.value = JSON.stringify(ops)
    this.contentHtmlTarget.value = html
  }

  decode() {
    const data = this.contentTarget.value ? JSON.parse(this.contentTarget.value) : []

    this.quill.setContents(data)
  }
}
