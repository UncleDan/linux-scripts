#!/bin/bash
echo "*** INSTALLING..."
echo ""
echo "* Invoicex..."
echo ""
wget http://server.invoicex.it/download/setup/Invoicex_Setup_2.0.1_20181228_linux.zip
unzip Invoicex_Setup_2.0.1_20181228_linux.zip
rm -rf Invoicex_Setup_2.0.1_20181228_linux.zip
InvoicexSetup/InvoicexSetup
rm -rf InvoicexSetup
echo ""
echo ""
echo "DONE."
