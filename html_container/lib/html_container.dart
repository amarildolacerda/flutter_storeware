library html_container;

import "package:html_container_io/html_container_io.dart"
    if (dart.library.js) "package:html_container_web/html_container_web.dart";

class HtmlElementContainer<T> extends HtmlElementContainerImpls {}
