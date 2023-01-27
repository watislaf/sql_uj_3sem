import {ReactElement} from "react";
import {makeStyles} from "@material-ui/core";
import Loader from "../Loder/Loader";

type Props = {
    children: ReactElement,
    isLoading: boolean
}

const useStyles = makeStyles(() => ({
    mainContainer: {
        maxWidth: 700,
        margin: 'auto',
        height: 'calc(100vh - 64px)',
        background: 'azure',
        padding: 20
    },
}));

const Boody = ({children, isLoading}: Props) => {
    const {mainContainer} = useStyles();

    return <>
        {isLoading ? <Loader/> : null}
        <div className={mainContainer}>
            {children}
        </div>
    </>
}

export default Boody;
