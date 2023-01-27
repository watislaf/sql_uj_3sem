import {useParams} from "react-router-dom";
import React, {useEffect, useState} from "react";
import {DataGrid} from '@mui/x-data-grid'
import getColums, {fetchData} from "../../common/utils/Utils";
import {Box} from "@mui/material";
import {makeStyles, Typography} from "@material-ui/core";

type UrlProps = {
    id: string
}

type Props = {
    setLoading: (value: boolean) => void;
}

const Select = ({setLoading}: Props) => {
    const {id} = useParams<UrlProps>();
    const [data, setData] = useState(null);
    const {header} = useStyles();

    useEffect(() => {
        setLoading(true);
        fetchData('api/select/?databaseName=' + id, setData,
            () => setLoading(false));
    }, [id])

    if (!data) return <></>;

    return <div>
        <Typography variant="h4" component="h2" className={header}>
            Select from table
        </Typography>
        <Box sx={{height: 400, width: '100%'}}>
            <DataGrid
                rows={data}
                columns={getColums(data)}
                pageSize={10}
                rowsPerPageOptions={[10]}
            />
        </Box>
    </div>
}

const useStyles = makeStyles({
    header: {
        margin: 20,
    }
})
export default Select;
