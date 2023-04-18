import * as Uebersicht from 'uebersicht'
import styles from "./styles.jsx";
import run from "uebersicht";

const containerStyle = {
    display: "grid",
    gridAutoFlow: "column",
    gridGap: "14px",
    fontSize: "8px",
    fontFamily: "'Font Awesome 5 Free Solid'"
};

const desktopStyle = {
    width: "54px",
    height: "16px",
    textAlign: "center"
};

const symbols = ["globe", "terminal", "book", "desktop", "code", "question"];
const hideText = true;

const renderSpace = (display_index, index, focused, visible, windows) => {
    let contentStyle = JSON.parse(JSON.stringify(desktopStyle));
    let hasWindows = windows.length > 0;
    let shouldUseSymbols = display_index == 1 && index - 1 < symbols.length;
    if (focused == 1) {
        contentStyle.backgroundColor = '#ffffffff';
        contentStyle.color = '#ffffff';
    } else {
        contentStyle.backgroundColor = '#ffffff33';
        contentStyle.color = '#ffffff33';
    }

    contentStyle.borderRadius = '4px';
    contentStyle.height = '4px';

    if (!shouldUseSymbols) {
        contentStyle.fontFamily = "monospace";
    }

    const onClick = (e) => {
        Uebersicht.run(`/Users/tomerrosenfeld/.config/skhd/switch_to_space.sh ${index}`)
    }

    return (
    <Uebersicht.React.Fragment>
        <div key={index} style={contentStyle} onClick={onClick}>
            {hideText ? null : shouldUseSymbols ? symbols[index - 1] : (index)}
        </div>
    </Uebersicht.React.Fragment>
    );
};

const render = ({ output }) => {
    if (typeof output === "undefined") return null;

    const spaces = [];

    output.forEach(function(space) {
        spaces.push(renderSpace(space.display, space.index, space["has-focus"], space["is-visible"], space.windows));
    });

    return (
        <div style={containerStyle}>
            {spaces}
        </div>
    );
};

export default render;
