import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    id: window
    initialPage: Component { FirstPage { } }
    allowedOrientations: Orientation.Landscape
}
