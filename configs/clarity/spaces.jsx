import * as Uebersicht from 'uebersicht'
import Desktop from "./lib/Desktop.jsx";
import Error from "./lib/Error.jsx";
import parse from "./lib/parse.jsx";
import styles from "./lib/styles.jsx";

const style = {
    padding: "0 8px",
    display: "grid",
    gridAutoFlow: "column",
    gridGap: "16px",
    position: "fixed",
    overflow: "hidden",
    padding: "0px",
    width: "auto",
    top: "0px",
    left: "16px",
    fontFamily: styles.fontFamily,
    lineHeight: styles.lineHeight,
    fontSize: styles.fontSize,
    color: styles.colors.dim,
    fontWeight: styles.fontWeight
};

export const command = "./clarity/scripts/spaces.sh";

export const render = ({ output }, ...args) => {
    const data = parse(output);
    if (typeof data === "undefined") {
        return (
            <div style={style}>
                <Error msg="Error: unknown script output" side="left" />
            </div>
        );
    }
    if (typeof data.error !== "undefined") {
        return (
            <div style={style}>
                <Error msg={`Error: ${data.error}`} side="left" />
            </div>
        );
    }
    const displayId = Number(window.location.pathname.substr(1,1));
    const display = data.displays.find(d => d.id === displayId);
    return (
        <div style={style}>
            <Desktop output={data.spaces.filter(s => s.display === display.index)} />
        </div>
    );
};

export default null;
