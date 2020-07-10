<?xml version="1.0" encoding="utf-8"?>

<!-- OrderListLetter.xsl -->

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
	<html>
		<head>
		<xsl:call-template name="generalStyle" />
		</head>

			<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>

				<xsl:call-template name="head" /> <!-- header.xsl -->
				<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

				<br />
				<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

				<xsl:for-each select="notification_data/letter_texts">
				<table cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>@@place_order_introduction@@:</td>
					</tr>
				</table>
				<br />

				</xsl:for-each>
				<xsl:for-each select="notification_data">
				<table>
					<!-- adding order number with test on preferred language for the vendor 
					nicomo - 20191205 -->
					<xsl:choose>
						<xsl:when test="/notification_data/receivers/receiver/preferred_language = 'fr'">
							<tr>
								<td><b>Num. de bon de commande: </b> <xsl:value-of select="/notification_data/po/number"/></td>
							</tr>
							<xsl:if test="/notification_data/po/erp_number != ''">
								<tr>
									<td><b>@@erp_number@@: </b><xsl:value-of select="/notification_data/po/erp_number"/></td>
								</tr>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td><b>Order #: </b> <xsl:value-of select="/notification_data/po/number"/></td>
							</tr>
							<xsl:if test="/notification_data/po/erp_number != ''">
								<tr>
									<td><b>@@erp_number@@: </b><xsl:value-of select="/notification_data/po/erp_number"/></td>
								</tr>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
					<tr>
						<td><b>@@order_date@@: </b> <xsl:value-of select="/notification_data/po/create_date"/></td>
					</tr>
					<tr>
						<td><b>@@vendor_account@@: </b><xsl:value-of select="/notification_data/po/vendor_account/description"/></td>
					</tr>
					<tr>
						<td><b>@@shipping_address@@: </b><xsl:value-of select="/notification_data/po/ship_to_address/line1"/>&#160;<xsl:value-of select="/notification_data/po/ship_to_address/line2"/>&#160;<xsl:value-of select="/notification_data/po/ship_to_address/city"/>&#160;<xsl:value-of select="/notification_data/po/ship_to_address/country"/></td>
					</tr>
					<!-- shipping method removed, never used - nicomo 2019-12-05
					<tr>
						<td><b>@@shipping_method@@: </b><xsl:value-of select="/notification_data/po/shipping_method"/></td>
					</tr> 
					-->
					<!-- billing address always the same and known by vendor.
					Does not need to be specified on each order.
					nicomo - 20191205
					<tr>
						<td><b>@@billing_address@@: </b><xsl:value-of select="/notification_data/po/bill_to_address/line1"/>&#160;<xsl:value-of select="/notification_data/po/bill_to_address/line2"/>&#160;<xsl:value-of select="/notification_data/po/bill_to_address/city"/>&#160;<xsl:value-of select="/notification_data/po/bill_to_address/country"/></td>
					</tr>
					-->
				</table>
				</xsl:for-each>
				<br />


				<table cellpadding="5" class="listing">
				<xsl:attribute name="style">
					<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>


				<!-- change orientation of table for PO Lines
				adding information: document date, publisher. 
				Removing order date: we use the date of the PO, not of each PO Line
				nicomo 20191205 -->
				<xsl:for-each select="notification_data/po/po_line_list/po_line">
					<tr>
						<th scope="row">@@po_line_number@@</th>
						<td><xsl:value-of select="line_reference"/></td>
					</tr>
					<tr>
						<th scope="row">@@issn_isbn@@</th>
						<td><xsl:value-of select="identifier_type"/>&#160;<xsl:value-of select="identifier"/></td>
					</tr>
					<tr>
						<th scope="row">@@title@@</th>
						<td>
							<xsl:value-of select="meta_data_values/title"/>
							<xsl:if test="meta_data_values/publisher != ''">
								&#160;<xsl:value-of select="meta_data_values/publisher"/>
							</xsl:if>
							<xsl:if test="meta_data_values/acqterms_edition != ''">
								&#160;<xsl:value-of select="meta_data_values/acqterms_edition"/>
							</xsl:if>
							<xsl:if test="meta_data_values/date != ''">
								&#160;<xsl:value-of select="meta_data_values/date"/>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<th scope="row">@@price@@</th>
						<td><xsl:value-of select="total_price_compose/currency"/>&#160;<xsl:value-of select="total_price_compose_with_normalized_sum/normalized_sum"/></td>
					</tr>
					<tr>
						<th scope="row">@@quantity@@</th>
						<td><xsl:value-of select="total_quantity"/></td>
					</tr>
					<!-- only display note if content exists
					nicomo - 20191205 -->
					<xsl:if test="vendor_note != ''">
						<tr>
							<th scope="row">@@note@@</th>
							<td><xsl:value-of select="vendor_note"/></td>
						</tr>
					</xsl:if>
					<tr>
						<td></td>
						<td><hr /></td>
					</tr>
				</xsl:for-each>
				<!-- end of refactored table for PO lines -->

				</table>
				<br />
				<table>

						<tr><td>@@sincerely@@</td></tr>
						<tr><td>@@department@@</td></tr>

				</table>


				<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>