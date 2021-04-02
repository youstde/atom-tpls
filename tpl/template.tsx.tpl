import React, { useState } from 'react';
import moment from 'moment';
import { Form } from 'antd';
import { Button } from 'antd';
import BreadCrumb from '@/components/ui/breadCrumb';
import { MxCard, MxTable, MxFilter } from '@/components/mx-page';
import TableOperationGroup from '@/components/ui/tableOperationGroup';

import useData from './useData';
import { listCrumb } from './const';
import styles from './$atom$.css';

const $atom$ = () => {
  const [form] = Form.useForm();
  const { tableProps, search, refresh } = useData(form);

  const { submit, reset } = search;

  const operateBlock = (data) => {
    return (
      <TableOperationGroup
        operations={
          [
            {
              title: '编辑',
              show: true,
              func: () => {}
            }
          ]
        }
      />
    );
  };

  const columns = [
    {
      title: '创建时间',
      key: 'createdTime',
      dataIndex: 'createdTime',
      render(createdTime) {
        return moment(createdTime).format('YYYY/MM/DD HH:mm:ss')
      }
    },
    {
      title: '编号',
      key: 'supplierNo',
      dataIndex: 'supplierNo'
    },
    {
      title: '操作',
      render(record) {
        return operateBlock(record);
      }
    }
  ];

  const formProps = {
    form,
    initialValues: {
      status: 'all',
      recommenderUid: 'all'
    }
  };

  const formItems = [
    {
      formItem: {
        label: '创建时间',
        name: 'createdTime'
      },
      item: {
        type: 'RangePicker',
        props: {
          style: {
            width: '100%'
          },
        }
      }
    },
    {
      formItem: {
        label: '公司名称',
        name: 'companyName'
      },
      item: {
        type: 'Input',
        props: {
          style: {
            width: '100%'
          },
        }
      }
    }
  ];

  const buttonItems = [
    {
      props: {
        onClick:submit,
        type: 'primary',
        children: '筛选'
      },
    },
    {
      props: {
        onClick:reset,
        children: '重置'
      },
    },
  ];

  return (
    <>
      <BreadCrumb crumbs={listCrumb} />
      <MxCard>
        <MxFilter formProps={formProps} formItems={formItems} buttons={buttonItems} />
      </MxCard>
      <MxCard>
        <Button
          style={{ marginBottom: '20px' }}
          type="primary"
        >
          新增
        </Button>
        <MxTable
          rowKey="supplierNo"
          columns={columns}
          {...tableProps}
        />
      </MxCard>
    </>
  )
};

export default $atom$;