import * as React from 'react';
import { styled } from '@mui/material/styles';

const Div = styled('div')(({ theme }) => ({
  ...theme.typography.button,
  backgroundColor: theme.palette.background.paper,
  padding: theme.spacing(1),
}));

export default function TypographyTheme({label}) {
  return <Div sx={{ fontWeight: 'bold', fontSize:'150%' }}>{label}</Div>;
}