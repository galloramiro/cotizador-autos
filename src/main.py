import aspose.words as aw


if __name__ == "__main__":
    fileNames = [ "/app/docs/01_indice.md"]

    output = aw.Document()
    # Remove all content from the destination document before appending.
    output.remove_all_children()

    for fileName in fileNames:
        input = aw.Document(fileName)
        # Append the source document to the end of the destination document.
        output.append_document(input, aw.ImportFormatMode.KEEP_SOURCE_FORMATTING)

    output.save("/app/docs/discovery_cotizador_autos.pdf")
